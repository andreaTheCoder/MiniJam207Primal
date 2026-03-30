extends Node2D
@onready var Text : RichTextLabel = $RichTextLabel
@onready var Fade : CanvasLayer = $Fade
const START = preload("res://scenes/start.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fade.fade(1, 0)
	Fade.fade(0, 1)
	if Global.score != 0:
		Text.text = "All the crimes got traced back to you, with you killing "
		Text.text += str(int(float(Global.score)/200))
		Text.text += " people and your shop got shut down."
	else:
		Text.text = "You have not made a single potion that the landlords around you have gotten fed up with this unused land, thus they convict you of murder and shuts you down."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_restart_button_button_down() -> void:
	EventBus.button_pressed.emit(true)

func _on_restart_button_button_up() -> void:
	EventBus.button_pressed.emit(false)
	get_tree().change_scene_to_packed(START)
