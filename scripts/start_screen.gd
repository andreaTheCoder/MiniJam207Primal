extends Node2D

const SHOP = preload("res://scenes/shop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func button_pressed(isDown):
	if isDown:
		AudioPlayer.play_sfx(AudioPlayer.BUTTON_DOWN, 15)
	else:
		AudioPlayer.play_sfx(AudioPlayer.BUTTON_UP, 15)

func _on_start_screen_button_button_down() -> void:
	button_pressed(true)

func _on_start_screen_button_button_up() -> void:
	button_pressed(false)
	get_tree().change_scene_to_packed(SHOP)



func _on_start_screen_tutorial_button_button_down() -> void:
	button_pressed(true)


func _on_start_screen_tutorial_button_button_up() -> void:
	button_pressed(false)
	get_tree().change_scene_to_packed(load("res://scenes/cutscene_tutorial.tscn"))
