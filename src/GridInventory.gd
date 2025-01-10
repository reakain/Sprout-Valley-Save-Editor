extends GridContainer

var container_content:Dictionary
var ui_items:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func populate_contents(inventory_content):
	container_content = inventory_content
	for key in container_content.keys():
		add_item(key, container_content[key])

func clear_contents():
	for child_box in self.get_children():
		self.remove_child(child_box)
	
func get_contents():
	for key in ui_items.keys():
		container_content[key] = int(ui_items[key].text)
	return container_content

func add_item(item_id,item_num):
	var item_info = ItemsDb.by_id(item_id)
	var itemicon = TextureRect.new()
	var atlastex = AtlasTexture.new()
	atlastex.atlas = load("res://assets/Items.png")
	var y_pos = floor(item_info.frame / 8)
	var x_pos = int(item_info.frame) % 8
	x_pos = x_pos * 16
	y_pos = y_pos * 16
	atlastex.region = Rect2(Vector2(x_pos, y_pos), Vector2(16, 16))
	itemicon.texture = atlastex
	itemicon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	itemicon.size_flags_vertical = SIZE_EXPAND_FILL
	itemicon.size_flags_horizontal = SIZE_EXPAND_FILL
	self.add_child(itemicon)
	var itemnum = LineEdit.new()
	itemnum.text = str(item_num)
	self.add_child(itemnum)
	ui_items[item_id] = itemnum


func _on_OptionButton_item_selected_id(item_id):
	add_item(item_id, 1)
