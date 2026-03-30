
extends TextureRect

var current_step = 0
const SHOP = preload("res://scenes/shop.tscn")

var images = ["res://art/News 1.png", "res://art/News 2.png", "res://art/News 3.png", "res://art/News 4.png", "res://art/News 5.png", "res://art/News 6.png", "res://art/News 7.png"]
var image = "res://art/News " + str(Global.day) + ".png"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	EventBus.day_end.connect(_newspaper_update)
	top_level = true
	print(image)
	texture = load(image) 
	
		
func _process(_delta: float) -> void:
	pass

func _newspaper_update():
	image = "res://art/News " + str(Global.day) + ".png"
	texture = load(image)
