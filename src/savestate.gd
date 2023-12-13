extends Node


extends Node

const save_slots: = [
	"user://save_state.sav", 
	"user://save_state_1.sav", 
	"user://save_state_2.sav", 
	"user://save_state_3.sav", 
	"user://save_state_4.sav", 
	"user://save_state_5.sav", 
	"user://save_state_6.sav", 
	"user://save_state_7.sav", 
	"user://save_state_8.sav", 
	"user://save_state_9.sav"
]
const flags_path: = "user://game_flags.sav"
const passphrase: = "u)/W87l&9-=~tRsElB"
const version: = 0.2

var SavingMessage = preload("res://src/UI/SavingMessage.tscn")
var disabled:bool = ProjectSettings.get("custom/debug/save_disabled")
var save_data:Dictionary
var has_save_data: = false
var slot: = 0
var preloaded_slots: = []
var game_finished: = false

signal saved
signal loaded

func _ready():
	load_global_flags()

func edit_save():
	load_state()
	saved_data.farming_exp

func persist_save()->Dictionary:
	return {
		"shippings_done":Storyline.shippings_done, 
		"crafts_done":Storyline.crafts_done, 
		"plants_harvested":Storyline.plants_harvested, 
		"trees_destroyed":Storyline.trees_destroyed, 
		"rocks_destroyed":Storyline.rocks_destroyed, 
		"fish_caught":Storyline.fish_caught, 
		"fish_cought_ids":Storyline.fish_cought_ids, 
		"rescues_done":Storyline.rescues_done, 
		"travels_done":Storyline.travels_done, 
		"money_earned":Storyline.money_earned, 
		"farming_exp":Storyline.farming_exp, 
		"mining_exp":Storyline.mining_exp, 
		"foraging_exp":Storyline.foraging_exp, 
		"crafting_exp":Storyline.crafting_exp, 
		"fishing_exp":Storyline.fishing_exp, 
	}

func persist_load(data:Dictionary):
	Storyline.shippings_done = data.shippings_done
	Storyline.crafts_done = data.crafts_done
	Storyline.plants_harvested = data.plants_harvested if data.has("plants_harvested") else 0
	Storyline.trees_destroyed = data.trees_destroyed if data.has("trees_destroyed") else 0
	Storyline.rocks_destroyed = data.rocks_destroyed if data.has("rocks_destroyed") else 0
	Storyline.fish_caught = data.fish_caught if data.has("fish_caught") else 0
	Storyline.fish_cought_ids = data.fish_cought_ids if data.has("fish_cought_ids") else []
	Storyline.money_earned = data.money_earned if data.has("money_earned") else 0
	Storyline.rescues_done = data.rescues_done if data.has("rescues_done") else 0
	Storyline.travels_done = data.travels_done if data.has("travels_done") else 0
	Storyline.farming_exp = data.farming_exp if data.has("farming_exp") else 0
	Storyline.mining_exp = data.mining_exp if data.has("mining_exp") else 0
	Storyline.foraging_exp = data.foraging_exp if data.has("foraging_exp") else 0
	Storyline.crafting_exp = data.crafting_exp if data.has("crafting_exp") else 0
	Storyline.fishing_exp = data.fishing_exp if data.has("fishing_exp") else 0

func save_global_flags():
	var save_file = File.new()

	save_file.open_encrypted_with_pass(flags_path, File.WRITE, passphrase)

	save_file.store_line(to_json({
		"game_finished":game_finished, 
	}))
	save_file.close()

func load_global_flags():
	var save_file = File.new()

	if not save_file.file_exists(flags_path):
		game_finished = false

		return 

	save_file.open_encrypted_with_pass(flags_path, File.READ, passphrase)

	var data = parse_json(save_file.get_line())

	game_finished = data.game_finished

func get_nodes_snapshot():
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var nodes_data = []

	for node in save_nodes:
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)

			continue

		if not node.has_method("persist_save"):
			print("persistent node '%s' is missing a persist_save() function, skipped" % node.name)

			continue

		var node_data = node.call("persist_save")

		nodes_data.append(node_data)

	return nodes_data

func save_state():
	if disabled:
		emit_signal("saved")

		return 

	var saving_message = SavingMessage.instance()

	add_child(saving_message)

	var save_file = File.new()

	save_file.open_encrypted_with_pass(save_slots[slot], File.WRITE, passphrase)

	save_file.store_line(to_json({
		"nodes":get_nodes_snapshot(), 
		"version":version
	}))
	save_file.close()

	emit_signal("saved")

func load_state():
	if disabled:
		emit_signal("loaded")

		return 

	var save_file = File.new()

	if not save_file.file_exists(save_slots[slot]):
		has_save_data = false

		emit_signal("loaded")

		return 

	save_file.open_encrypted_with_pass(save_slots[slot], File.READ, passphrase)
	

	var data = parse_json(save_file.get_line())
	var plaintext_file = File.new()

	has_save_data = true

	if data.version != version:
		_migrate_save(data)
	else :
		_restore_save(data)

	save_file.close()

	emit_signal("loaded")

func clear_state():
	if disabled:
		return 

	has_save_data = false

	var dir = Directory.new()

	dir.remove(save_slots[slot])

func clear_state_at_slot(index:int):
	if disabled:
		return 

	if save_slots.size() > index:
		preloaded_slots[index] = null

		var dir = Directory.new()

		dir.remove(save_slots[index])

func preload_states():
	preloaded_slots = []

	for save_slot_path in save_slots:
		var save_file = File.new()

		if not save_file.file_exists(save_slot_path):
			preloaded_slots.append(null)

			continue

		save_file.open_encrypted_with_pass(save_slot_path, File.READ, passphrase)

		var data = parse_json(save_file.get_line())
		var coins = 0.0
		var label = "0"
		var days = 0
		var hat_id = ""

		
		if not data or not data.has("version") or data.version != version:
			var dir = Directory.new()

			dir.remove(save_slot_path)

			continue

		for node_data in data.nodes:
			if node_data.filename:
				if "Player.tscn" in node_data.filename:
					coins = node_data.coins
					hat_id = node_data.hat_id if node_data.has("hat_id") else ""

				if "LevelGenerator.tscn" in node_data.filename:
					days = node_data.day_cycle_days_passed
					label = node_data.world_label if node_data.has("world_label") else str(node_data.world_seed)

		preloaded_slots.append({
			"coins":coins, 
			"label":label, 
			"days":days, 
			"hat_id":hat_id
		})

func restore_level(level, snapshot = null):
	level.show_loading()

	var timer = Timer.new()
	var nodes_data = snapshot if snapshot else save_data.nodes
	var append_queue = []

	timer.one_shot = true

	add_child(timer)

	timer.start(1.0)

	for node_data in nodes_data:
		var existing_node = get_tree().root.get_node_or_null(node_data.path)

		if existing_node:
			existing_node.persist_load(node_data)
		elif ResourceLoader.exists(node_data["filename"]):
			var new_object = load(node_data["filename"]).instance()
			var parent = get_tree().root.get_node_or_null(node_data["parent"])

			if not parent:
				print("parent for persistent node '%s' is missing, skipped" % node_data.filename)

				continue

			new_object.persist_load(node_data)

			append_queue.append([parent, new_object])
		else :
			print("node '%s' does not exists, skipped" % node_data.filename)

	for item in append_queue:
		item[0].add_child(item[1])

	append_queue.clear()

	for node_data in nodes_data:
		var existing_node = get_tree().root.get_node_or_null(node_data.path)

		if existing_node and existing_node.has_method("childs_loaded"):
			existing_node.childs_loaded(node_data)

	if timer.is_stopped():
		_on_LoadingTimer_timeout(level, snapshot)
	else :
		timer.connect("timeout", self, "_on_LoadingTimer_timeout", [level, snapshot])

func _on_LoadingTimer_timeout(level, snapshot):
	Weather.restore_weather()

	if not snapshot:
		level.advance_cycle()

	level.hide_loading()

func _restore_save(data:Dictionary):
	save_data = data

func _migrate_save(data:Dictionary):
	save_data = data
