
extends Node2D

@export var sprite: Sprite2D
@onready var fade: CanvasLayer = $Fade
var current_step = 0
const SHOP = preload("res://scenes/shop.tscn")

var newspaper_images : Array = [
	"res://art/tray.png", 
	"res://art/tray.png", 
	"res://art/tray.png", 
	"res://art/tray.png", 
]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	sprite.texture = load(newspaper_images[Global.day-1])
	
		
