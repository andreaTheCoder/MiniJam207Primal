extends Node2D

const START = preload("res://scenes/start.tscn")

@onready var Text : RichTextLabel = $RichTextLabel
@onready var Fade : CanvasLayer = $Fade

func _ready() -> void:
	Fade.fade(1, 0)
	Fade.fade(0, 1)
	if Global.score != 0:
		Text.text = "All the crimes got traced back to you, with you killing " + str(int(float(Global.score)/200)) + " people and your shop got shut down."
	else:
		Text.text = "Your store has not made a single cent, making others wonder why you even own that land in the first place. They decide to convict you for murder and shut you down to claim the property."

func _on_restart_button_button_down() -> void:
	AudioPlayer.play_sfx(AudioPlayer.BUTTON_DOWN)

func _on_restart_button_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.BUTTON_UP)
	get_tree().change_scene_to_packed(START)
