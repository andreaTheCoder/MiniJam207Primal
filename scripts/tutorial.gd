extends Node2D

const GAME = preload("res://scenes/game.tscn")

@onready var tutorial_label: RichTextLabel = $CanvasLayer/TutorialLabel
@onready var tutorial_sprite: Sprite2D = $CanvasLayer/TutorialImage
@onready var start_button: Button = $CanvasLayer/StartButton
@onready var fade: CanvasLayer = $Fade

@export var current_step = 0
@export var image = image_to_load(current_step)

var tutorial_text : Array = [
	"",
	"You are starting the very first potion store ever!",
	"It's up to you to show the world how awesome potions are",
	"Find your orders for the day here, with the ingredients to make it",
	"Drag the ingredients to the potion to add them in",
	"When your done, drag the potion to the tray. Or discard your potion",
	"Try to complete your orders by the end of the day! Time is ticking.",
	"This game is best played in fullscreen"
]

func _ready() -> void:
	loadIndexItems(current_step, false)

func _process(_delta: float) -> void:
	if Input.is_action_just_released("click") or Input.is_action_just_released("ui_accept"):
		# Subtracts -1 prevents OBO error
		# .size() is not zero indexed but current_step is
		
		# Can start at one since the 0 loads at ready()
		current_step += 1
		if current_step <= tutorial_text.size() - 1:
			loadIndexItems(current_step, true)

func loadIndexItems(index, is_fading: bool):
	if is_fading:
		await fade.fade(1, 0.2).finished
		tutorial_sprite.texture = load(image_to_load(current_step))
		if current_step == tutorial_text.size() - 1:
			# shows start button to start game
			start_button.show()
			$CanvasLayer/ClickToContinueLabel.hide()
		tutorial_label.text = tutorial_text[index]
		await fade.fade(0, 0.2).finished
	else:
		# just load it without tweeners
		tutorial_label.text = tutorial_text[index]
		tutorial_sprite.texture = load(image_to_load(current_step))

func _on_start_button_pressed() -> void:
	EventBus.button_pressed.emit(false)
	await fade.fade(1, 2.0).finished
	get_tree().change_scene_to_packed(Global.SHOP)

func _on_start_button_button_down() -> void:
	EventBus.button_pressed.emit(true)

func image_to_load(index):
	var loading_image = "res://art/tutorial/" + str(index + 1) + ".PNG"
	return loading_image
