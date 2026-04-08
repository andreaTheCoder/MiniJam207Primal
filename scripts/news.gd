extends Node2D
@onready var Text : RichTextLabel = $RichTextLabel
@onready var Fade : CanvasLayer = $Fade
const START = preload("res://scenes/start.tscn")

func _ready() -> void:
	Fade.fade(1, 0)
	Fade.fade(0, 1)
	if Global.score != 0:
		Text.text = "All the crimes got traced back to you, with you killing "
		Text.text += str(int(float(Global.score)/200))
		Text.text += " people and your shop got shut down."
	else:
		Text.text = "Your store has not made a single cent, making others wonder why you even own that land in the first place. They decide to convict you for murder and shut you down to claim the property."

func _on_restart_button_button_down() -> void:
	EventBus.button_pressed.emit(true)

func _on_restart_button_pressed() -> void:
	EventBus.button_pressed.emit(false)
	get_tree().change_scene_to_packed(START)
