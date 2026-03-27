extends Node2D

@onready var start_screen_tutorial_button: Button = $CanvasLayer/StartScreenTutorialButton
@onready var start_screen_button: Button = $CanvasLayer/StartScreenButton
const SHOP = preload("res://scenes/shop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_screen_button_pressed() -> void:
	get_tree().change_scene_to_packed(Global.SHOP)


func _on_start_screen_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/cutscene_tutorial.tscn"))
