
extends Node2D

@export var sprite: Sprite2D
@onready var fade: CanvasLayer = $Fade
var current_step = 0
const SHOP = preload("res://scenes/shop.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	name = "res://art/News "
	name += str(Global.day - 1)
	name += ".png"
	sprite.texture = load(name)
	
		
