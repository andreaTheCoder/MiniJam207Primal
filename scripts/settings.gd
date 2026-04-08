extends Node2D

@onready var back_button: Button = $BackButton
@onready var music_slider: HSlider = $"VBoxContainer2/Music Slider"
@onready var sfx_slider: HSlider = $"VBoxContainer2/SFX Slider"
@onready var time_button: Button = $"VBoxContainer2/Time Button"

func _ready() -> void:
	if Global.Hour_Clock_24:
		time_button.text = "24 Hour Clock"
	else:
		time_button.text = "12 Hour Clock"
	music_slider.value = AudioPlayer.Music_Volume_Modifier * 100
	sfx_slider.value = AudioPlayer.SFX_Volume_Modifier * 100

func _slider_value_changed(value: float, source: Range) -> void:
	if source == music_slider:
		AudioPlayer.Music_Volume_Modifier = value/100
	elif source == sfx_slider:
		AudioPlayer.SFX_Volume_Modifier = value/100

func _button_down() -> void:
	EventBus.button_pressed.emit(true)

func _button_pressed(source: BaseButton) -> void:
	EventBus.button_pressed.emit(false)

	if source == back_button:
		get_tree().change_scene_to_packed(load("res://scenes/start.tscn"))
	if source == time_button:
		Global.Hour_Clock_24 = !Global.Hour_Clock_24
		if Global.Hour_Clock_24:
			time_button.text = "24 Hour Clock"
		else:
			time_button.text = "12 Hour Clock"
