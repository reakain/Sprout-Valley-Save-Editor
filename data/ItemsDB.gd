extends Node

const stone_id = "Hy8Ni"
const clay_id = "CpIGU"
const wood_id = "8c-jn"
const magic_dust_id = "ks33A"
const fiber_id = "zT7L7"
const wood_log_id = "YGeqR"
const chest_expansion_id = "085nz"
const backpack_expansion_id = "tFoU0"
const fence_id = "NgHbD"
const wood_path_id = "iknA6"
const stone_path_id = "SSZHT"
const star_fruit_id = "IsjvA"
const wood_bridge_id = "jGBn-"
const bare_bush_id = "mhTja"
const lantern_id = "ABVMh"
const wizard_hat_id = "hu4WQ"
const travel_supplies_id = "2nJG6"
const honeycomb_id = "Mtfxp"
const sprinkler_id = "81dLO"
const advanced_sprinkler_id = "2ocAS"
const magic_sprinkler_id = "7KDsO"
const wooden_chair_id = "WN8IQ"
const wooden_desk_id = "G45NP"
const stone_chair_id = "_6gvT"
const stone_desk_id = "cLwWu"
const bucket_id = "qZDmY"
const mining_car_id = "PEpdo"
const metal_box_id = "oOoXk"
const ground_lantern_id = "j89zH"
const street_lamp_id = "4F9GV"
const curved_street_lamp_id = "staHt"
const brick_oven_id = "2aJgV"
const moai_statue_id = "vsNt7"
const toolbox_id = "7QSqf"
const scarecrow_id = "x5C6u"
const spooky_scarecrow_id = "E_7CF"
const stack_of_hay_id = "x2GOM"
const red_flower_plant_id = "IEhhV"
const wooden_sign_id = "J5SPX"
const spooky_tower_id = "u83a7"
const garden_wagon_id = "YRYDC"
const bee_house_id = "b9ArP"
const garbage_bin_id = "Z4M1x"
const water_pump_id = "VCMBK"
const ant_farm_id = "lGzDc"
const blue_cute_lamp_id = "QWEp5"
const orange_cute_lamp_id = "RoabI"
const purple_cute_lamp_id = "UMdVL"
const metal_sign_id = "Arhfc"
const safe_id = "OSj9y"
const park_clock_id = "BdJI0"
const brown_mush_lamp_id = "LRt5F"
const purple_mush_lamp_id = "GIDx9"
const red_mush_lamp_id = "mFkzz"
const blue_mush_lamp_id = "zcB6P"
const meter_and_pipes_id = "OIa3q"
const tent_id = "JAMNv"
const mush_chair_id = "eJlOR"
const mush_desk_id = "gIGzB"
const dino_pet_id = "0MPiR"
const gear_apparatus_id = "L4-kF"
const bottled_ship_id = "TNe4T"
const frog_parasol_id = "5jfgD"
const green_parasol_id = "TuF4w"
const red_parasol_id = "h7Hu1"
const blue_parasol_id = "umIcM"
const sandbox_id = "8NtPK"
const clothesline_id = "wcKDz"
const mop_id = "Nnx95"
const giftpile_id = "sMrY8"
const green_giftbox_id = "XArCo"
const red_giftbox_id = "W3Ut9"
const carp_banner_id = "GslQs"
const anchovy_model_id = "Ud1jy"
const fresh_cooler_id = "Ex72O"
const shrimp_aquarium_id = "eaAIT"
const juice_maker_id = "g4lAx"
const fish_drying_rack_id = "yuqpO"
const dried_fish_id = "nzw8_"
const mossy_garden_rock_id = "0w_ft"
const stone_columns_id = "IeH96"
const beach_ball_id = "oHhBZ"
const birdhouse_id = "D7f0c"
const festive_tree_id = "Tqbxy"
const apple_tv_id = "UoSUh"
const barrel_bathtub_id = "CSl-t"
const hamster_cage_id = "OE0cg"
const coffee_grinder_id = "RJUQ6"
const cat_grass_id = "1t1tT"
const monstera_id = "gvW2n"
const mama_bear_id = "hl7rg"
const panda_bear_id = "Fwe7N"
const swinging_bench_id = "DtV7R"
const hourglass_id = "QHN8f"
const display_case_id = "3H4fF"
const shell_fountain_id = "W6oaA"
const globe_id = "ft80Q"
const fishing_rod_stand_id = "Oyk-I"
const umbrella_stand_id = "A09mV"
const signpost_id = "9ZNCD"
const windmill_id = "mL3ic"
const tiny_library_id = "fPCqO"
const retro_tv_id = "jVrHI"
const suspicious_cauldron_id = "ZeC_0"
const birthday_cake_id = "nwjyv"
const fish_containers_id = "LbMzM"
const colorful_wheel_id = "4EUDB"
const land_tile_id = "A30Mj"
const water_tile_id = "NMh8O"
const snow_globe_snowman_id = "1IyQP"
const snow_globe_penguin_id = "1ESUH"
const snow_globe_santa_id = "bbsdO"

var items_dict = {}
var plants_dict = {}
var trees_dict = {}
var bushes_dict = {}
var crafts_dict = {}
var abilities_dict = {}
var houses_dict = {}
var supply_bundles_dict = {}
var achievements_dict = {}
var juice_dict = {}
var recipes_dict = {}
var buffs_dict = {}
var seedlings_dict = {}

func _ready():
	var data_file = File.new()

	if not data_file.file_exists("res://data/Sprout Valley DB.json"):
		return 

	data_file.open("res://data/Sprout Valley DB.json", File.READ)

	var data = parse_json(data_file.get_as_text())

	items_dict = data[0]
	plants_dict = data[1]
	trees_dict = data[2]
	bushes_dict = data[3]
	crafts_dict = data[4]
	abilities_dict = data[5]
	houses_dict = data[6]
	supply_bundles_dict = data[7]
	achievements_dict = data[8]
	juice_dict = data[9]
	recipes_dict = data[10]
	buffs_dict = data[11]
	seedlings_dict = data[12]

	for key in crafts_dict.keys():
		crafts_dict[key]["ingredients"] = str2var(crafts_dict[key]["ingredients"])

func by_id(id:String):
	if not id:
		return null

	if items_dict.has(id):
		return items_dict[id]

	if plants_dict.has(id):
		return plants_dict[id]

	if seedlings_dict.has(id):
		return seedlings_dict[id]

	if trees_dict.has(id):
		return trees_dict[id]

	if bushes_dict.has(id):
		return bushes_dict[id]

	if crafts_dict.has(id):
		return crafts_dict[id]

	return null

func by_proficiency(farming:int, mining:int, foraging:int, crafting:int, fishing:int)->Array:
	var result = []

	for recipe_key in crafts_dict.keys():
		if int(crafts_dict[recipe_key].farming) == farming or int(crafts_dict[recipe_key].mining) == mining or int(crafts_dict[recipe_key].foraging) == foraging or int(crafts_dict[recipe_key].crafting) == crafting or int(crafts_dict[recipe_key].fishing) == fishing:
				result.append(recipe_key)

	return result

func by_proficiency_and_lower(farming:int, mining:int, foraging:int, crafting:int, fishing:int)->Array:
	var result = []

	for recipe_key in crafts_dict.keys():
		if int(crafts_dict[recipe_key].farming) <= farming and int(crafts_dict[recipe_key].mining) <= mining and int(crafts_dict[recipe_key].foraging) <= foraging and int(crafts_dict[recipe_key].crafting) <= crafting and int(crafts_dict[recipe_key].fishing) <= fishing:
				result.append(recipe_key)

	return result

func get_ability(name:String):
	if abilities_dict.has(name):
		return abilities_dict[name]

	return null

func get_house(id:String):
	if houses_dict.has(id):
		return houses_dict[id]

	return null

func get_achievement(id:String):
	if achievements_dict.has(id):
		return achievements_dict[id]

	return null

func get_supply_bundle(id:String):
	if supply_bundles_dict.has(id):
		return supply_bundles_dict[id]

	return null

func get_juice(id:String):
	if juice_dict.has(id):
		return juice_dict[id]

	return null

func get_recipe(id:String):
	if recipes_dict.has(id):
		return recipes_dict[id]

	return null

func get_buff(id:String):
	if buffs_dict.has(id):
		return str2var(buffs_dict[id].buffs)

	return null
