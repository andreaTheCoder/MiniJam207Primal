extends Node2D
@onready var Text : RichTextLabel = $RichTextLabel
@onready var Fade : CanvasLayer = $Fade
const START = preload("res://scenes/start.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fade.fade(1, 0)
	Fade.fade(0, 1)
	Text.text = "All the crimes got traced back to you, with you killing "
	Text.text += str(int(Global.score/200))
	Text.text += " people and your shop got shut down."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func button_pressed(isDown):
	if isDown:
		AudioPlayer.play_sfx(AudioPlayer.BUTTON_DOWN, 15)
	else:
		AudioPlayer.play_sfx(AudioPlayer.BUTTON_UP, 15)

func _on_restart_button_button_down() -> void:
	button_pressed(true)

func _on_restart_button_button_up() -> void:
	button_pressed(false)
	get_tree().change_scene_to_packed(START)
