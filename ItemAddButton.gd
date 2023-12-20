extends OptionButton

signal item_selected_id(item_id)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var item_options:Dictionary




# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0
	for item_id in ItemsDb.items_dict.keys():
		add_from_database(item_id, i)
		item_options[i] = item_id
		i = i+1

func add_from_database(item_id, index):
	var item_info = ItemsDb.by_id(item_id)
	var atlastex = AtlasTexture.new()
	atlastex.atlas = load("res://assets/Items.png")
	var y_pos = floor(item_info.frame / 8)
	var x_pos = int(item_info.frame) % 8
	x_pos = x_pos * 16
	y_pos = y_pos * 16
	atlastex.region = Rect2(Vector2(x_pos, y_pos), Vector2(16, 16))
	self.add_icon_item(atlastex, item_info.name, index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_OptionButton_item_selected(index):
	var item_id = item_options[index]
	emit_signal("item_selected_id", item_id)
	#item_selected_id.emit(item_id)
