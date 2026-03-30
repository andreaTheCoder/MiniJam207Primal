
extends TextureRect

@onready var fade: CanvasLayer = $Fade
var current_step = 0
const SHOP = preload("res://scenes/shop.tscn")

var images = ["res://art/News1.png", "res://art/News2.png", "res://art/News3.png", "res://art/News4.png", "res://art/News 5.png", "res://art/News 6.png", "res://art/News 7.png"]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:

	top_level = true
	print(images[Global.day-1])
	texture = load(images[Global.day-1]) 
	
		
func _process(delta: float) -> void:
	texture = load(images[Global.day-1]) 
