extends VBoxContainer

var container_content:Dictionary
var ui_items:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func populate_contents(inventory_content):
	container_content = inventory_content
	for key in container_content.keys():
		add_item(key, container_content[key])
	
func get_contents():
	for key in ui_items.keys():
		container_content[key] = int(ui_items[key].text)
	return container_content

func add_item(item_id,item_num):
	var item_info = ItemsDb.by_id(item_id)
	var itemhbox = HBoxContainer.new()
	itemhbox.alignment = ALIGN_END
	self.add_child(itemhbox)
	var itemicon = Sprite.new()
	itemicon.texture = load("res://assets/Items.png")
	itemicon.hframes = 8
	itemicon.vframes = 50
	itemicon.frame = item_info.frame
	itemicon.centered = false
	itemicon.scale = Vector2(2, 2)
	itemhbox.add_child(itemicon)
	var itemvbox = VBoxContainer.new()
	itemhbox.add_child(itemvbox)
	var itemlabel = Label.new()
	itemlabel.text = item_id
	itemvbox.add_child(itemlabel)
	var itemnum = LineEdit.new()
	itemnum.text = str(item_num)
	itemvbox.add_child(itemnum)
	ui_items[item_id] = itemnum

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
