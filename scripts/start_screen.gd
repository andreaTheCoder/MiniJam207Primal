extends Node2D
@onready var american_switch: Button = $"American Switch"
const BGM = preload("res://audio/Potion Shop BG Music #1.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.play_music(BGM, -5, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func _on_start_screen_button_button_down() -> void:
	EventBus.button_pressed.emit(true)

func _on_start_screen_button_pressed() -> void:
	EventBus.button_pressed.emit(false)
	get_tree().change_scene_to_packed(load("res://scenes/shop.tscn"))



func _on_start_screen_tutorial_button_button_down() -> void:
	EventBus.button_pressed.emit(true)

func _on_start_screen_tutorial_button_pressed() -> void:
	EventBus.button_pressed.emit(false)
	get_tree().change_scene_to_packed(load("res://scenes/cutscene_tutorial.tscn"))


func _on_american_switch_button_down() -> void:
	EventBus.button_pressed.emit(false)


func _on_american_switch_pressed() -> void:
	EventBus.button_pressed.emit(false)
	Global.American = !Global.American
	if Global.American:
		american_switch.text = "American"
	else:
		american_switch.text = "Not American"
