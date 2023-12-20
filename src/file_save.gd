extends Node

const default_save_name = "user://save_state.sav"
const default_plain_name = "user://decrypted_save.json"
const default_save_copy_name = "user://save_state_reencrypt.sav"
const default_passphrase: = "u)/W87l&9-=~tRsElB"

var save_data:Dictionary
var inventory_index = -1
var inventory_contents:Dictionary
var chest_index = -1
var chest_contents:Dictionary

var save_name: = default_save_name
var plain_name: = default_plain_name
var save_copy_name: = default_save_copy_name
var passphrase: = default_passphrase

func _ready():
	$VBoxContainer/HBoxPassphrase/TxtEditPassphrase.text = passphrase


func load_plain():
	var file = File.new()
	if file.file_exists(plain_name):
		file.open(plain_name, File.READ)
		var data = parse_json(file.get_line())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			save_data = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")


func save_plain():
	var file = File.new()
	file.open(plain_name, File.WRITE)
	file.store_string(to_json(save_data))
	file.close()


func load_encrypted():
	var file = File.new()
	if file.file_exists(save_name):
		file.open_encrypted_with_pass(save_name, File.READ, passphrase)
		var data = parse_json(file.get_line())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			save_data = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

func save_encrypted():
	var wfile = File.new()
	wfile.open_encrypted_with_pass(save_copy_name, File.WRITE, passphrase)
	wfile.store_line(to_json(save_data))
	wfile.close()
	
func change_passphrase(var new_passphrase):
	passphrase = new_passphrase


func populate_data():
	# Money? Money
	$VBoxContainer/GridContainer/TxtMoney.text = str(save_data.nodes[0].money_earned)
	$VBoxContainer/GridContainer/TxtFarmingExp.text = str(save_data.nodes[0].farming_exp)
	$VBoxContainer/GridContainer/TxtMiningExp.text = str(save_data.nodes[0].mining_exp)
	$VBoxContainer/GridContainer/TxtFishingExp.text = str(save_data.nodes[0].fishing_exp)
	$VBoxContainer/GridContainer/TxtForagingExp.text = str(save_data.nodes[0].foraging_exp)
	$VBoxContainer/GridContainer/TxtCraftingExp.text = str(save_data.nodes[0].crafting_exp)
	
	# Find in array with filename res://src/UI/Inventory.tscn  and then looks in contents_manager_contents
	for i in range(save_data.nodes.size()):
		if save_data.nodes[i].path == "/root/Game/LevelGenerator/YSort/Player/Inventory":
			inventory_index = i
			$VBoxContainer/HSplitContainer/VBoxInventory/GridInventory.populate_contents(save_data.nodes[inventory_index].contents_manager_contents)
		elif save_data.nodes[i].path == "/root/Game/LevelGenerator/YSort/PlayerHouse/Chest/ChestController/Inventory":
			chest_index = i
			#$VBoxContainer/HBoxContainer/VBoxChest.populate_contents(save_data.nodes[chest_index].contents_manager_contents)
			$VBoxContainer/HSplitContainer/VBoxChest/GridChest.populate_contents(save_data.nodes[chest_index].contents_manager_contents)
		if inventory_index > 0 && chest_index > 0:
			break

#func populate_container(isChest):
#	pass
#	# wood: 8c-jn
#	# travel supplies: nJG6
#	# stone: Hy8Ni
#	# clay: CpIGU
#	# log: YGeqR
#	# grass: zT7L7
#	# wheat seed: pBjFh
#	# carrot seed: wEjhx
#	if isChest:
#		for key in chest_contents.keys():
#			by_id(key)

func update_save_data():
	save_data.nodes[inventory_index].contents_manager_contents = $VBoxContainer/HSplitContainer/VBoxInventory/GridInventory.get_contents()
	save_data.nodes[chest_index].contents_manager_contents = $VBoxContainer/HSplitContainer/VBoxChest/GridChest.get_contents()
	#save_data.nodes[chest_index].contents_manager_contents = $VBoxContainer/HBoxContainer/VBoxChest.get_contents()
	save_data.nodes[0].money_earned = int($VBoxContainer/GridContainer/TxtMoney.text)
	save_data.nodes[0].farming_exp = float($VBoxContainer/GridContainer/TxtFarmingExp.text)
	save_data.nodes[0].mining_exp = float($VBoxContainer/GridContainer/TxtMiningExp.text)
	save_data.nodes[0].fishing_exp = float($VBoxContainer/GridContainer/TxtFishingExp.text)
	save_data.nodes[0].foraging_exp = float($VBoxContainer/GridContainer/TxtForagingExp.text)
	save_data.nodes[0].crafting_exp = float($VBoxContainer/GridContainer/TxtCraftingExp.text)


func _on_BtnLoadSave_pressed():
	$LoadSaveDialog.popup_centered()
	


func _on_BtnToPlaintext_pressed():
#	save_to_plaintext()
	$SavePlaintextDialog.popup_centered()


func _on_BtnToEncrypted_pressed():
	#reencode_save()
	$SaveSaveDialog.popup_centered()


func _on_BtnPassphraseUpdate_pressed():
	var new_pass = $PanelContainer/VBoxContainer/HBoxPassphrase/TxtEditPassphrase.text
	change_passphrase(new_pass)


func _on_TxtFarmingExp_text_changed(new_text):
	save_data.nodes[0].farming_exp = float(new_text)


func _on_TxtMiningExp_text_changed(new_text):
	save_data.nodes[0].mining_exp = float(new_text)


func _on_TxtFishingExp_text_changed(new_text):
	save_data.nodes[0].fishing_exp = float(new_text)


func _on_TxtForagingExp_text_changed(new_text):
	save_data.nodes[0].foraging_exp = float(new_text)


func _on_TxtMoney_text_changed(new_text):
	save_data.nodes[0].money_earned = int(new_text)


func _on_TxtCraftingExp_text_changed(new_text):
	save_data.nodes[0].crafting_exp = float(new_text)


func _on_PanelContainer_resized():
	CORNER_BOTTOM_RIGHT
	pass # Replace with function body.


func _on_LoadSaveDialog_custom_action(action):
	
	pass # Replace with function body.


func _on_LoadSaveDialog_file_selected(path):
	save_name = path
	load_encrypted()
	populate_data()
	$VBoxContainer/HBoxContainer2/BtnToPlaintext.disabled = false
	$VBoxContainer/HBoxContainer2/BtnToEncrypted.disabled = false


func _on_SavePlaintextDialog_file_selected(path):
	plain_name = path
	update_save_data()
	save_plain()



func _on_SaveSaveDialog_file_selected(path):
	save_copy_name = path
	update_save_data()
	save_encrypted()
