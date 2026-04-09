extends Node2D

@onready var tutorial_button: Button = $"CanvasLayer/VBoxContainer/StartScreenTutorialButton"
@onready var start_button: Button = $CanvasLayer/VBoxContainer/StartScreenStartButton
@onready var settings_button: Button = $StartScreenSettingsButton

func _ready() -> void:
	AudioPlayer.play_music(AudioPlayer.START_BGM, 1, true)

func _button_down() -> void:
	EventBus.button_pressed.emit(true)

func _button_pressed(source: BaseButton) -> void:
	EventBus.button_pressed.emit(false)
	match source:
		tutorial_button:
			get_tree().change_scene_to_packed(load("res://scenes/cutscene_tutorial.tscn"))
		start_button:
			get_tree().change_scene_to_packed(load("res://scenes/shop.tscn"))
		settings_button:
			get_tree().change_scene_to_packed(load("res://scenes/settings.tscn"))
