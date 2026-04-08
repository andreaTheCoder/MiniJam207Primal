extends Node2D

@onready var tutorial_button: Button = $"CanvasLayer/VBoxContainer/StartScreenTutorialButton"
@onready var start_button: Button = $CanvasLayer/VBoxContainer/StartScreenStartButton
@onready var american_button: Button = $"American Button"

func _ready() -> void:
	AudioPlayer.play_music(AudioPlayer.START_BGM, -5, true)
	if Global.American:
		american_button.text = "American"
	else:
		american_button.text = "Not American"

func _button_down() -> void:
	EventBus.button_pressed.emit(true)

func _button_pressed(source: BaseButton) -> void:
	EventBus.button_pressed.emit(false)
	if source == tutorial_button:
		get_tree().change_scene_to_packed(load("res://scenes/cutscene_tutorial.tscn"))
	elif source == start_button:
		get_tree().change_scene_to_packed(load("res://scenes/shop.tscn"))
	elif source == american_button:
		Global.American = !Global.American
		if Global.American:
			american_button.text = "American"
		else:
			american_button.text = "Not American"
