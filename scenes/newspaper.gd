
extends Node2D

@export var tutorial_sprite: Sprite2D
@onready var start_button: Button = $CanvasLayer/StartButton
@onready var fade: CanvasLayer = $Fade
var current_step = 0
const SHOP = preload("res://scenes/shop.tscn")

var newspaper_images : Array = [
	"res://art/tray.png", 
	"res://scenes/newspaper.tscn"
]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	tutorial_sprite.texture = load(newspaper_images[Global.day-1])
	print(tutorial_sprite.texture)
	if Input.is_action_just_released("click") or Input.is_action_just_released("ui_accept"):
		get_tree().change_scene_to_packed(SHOP)
	
		
