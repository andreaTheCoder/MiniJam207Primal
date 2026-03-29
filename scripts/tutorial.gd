
extends Node2D

@onready var tutorial_label: RichTextLabel = $CanvasLayer/TutorialLabel
@onready var tutorial_sprite: Sprite2D = $CanvasLayer/TutorialImage
@onready var start_button: Button = $CanvasLayer/StartButton
@onready var fade: CanvasLayer = $Fade

var current_step = 0
const GAME = preload("res://scenes/game.tscn")

var tutorial_data : Array = [
	{
		"text":"",
		"image_path":"res://art/tutorial/1.PNG"
	},
	{
		"text":"You are starting the very first potion store ever!",
		"image_path":"res://art/tutorial/2.PNG"
	},
	{
		"text":"It's up to you to show the world how awesome potions are",
		"image_path":"res://art/tutorial/3.PNG"
	},
	{
		"text":"Find your orders for the day here, with the ingredients to make it",
		"image_path":"res://art/tutorial/4.PNG"
	},
	{
		"text":"Drag the ingridients to the potion to add them in",
		"image_path":"res://art/tutorial/5.PNG"
	},
	{
		"text":"When your done, drag the potion to the tray. Or discard your potion",
		"image_path":"res://art/tutorial/6.PNG"
	},
	{
		"text":"Try to complete your orders by the end of the day! Time is ticking.",
		"image_path":"res://art/tutorial/7.PNG"
	},
	{
		"text":"",
		"image_path":"res://art/tutorial/8.PNG"
	},
]
func _ready() -> void:
	loadIndexItems(current_step, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("click") or Input.is_action_just_released("ui_accept"):
		# Subtracts -1 prevents OBO error
		# .size() is not zero indexed but current_step is
		
		# Can start at one since the 0 loads at ready()
		current_step += 1
		if not current_step > tutorial_data.size() - 1:
			loadIndexItems(current_step, true)


func loadIndexItems(index, is_fading: bool):
	if not tutorial_data[index]["image_path"]:
		printerr("Image Texture Doesn't Exist")
	# print(tutorial_data[index]["image_path"])
	if is_fading:
		await fade.fade(1, 0.2).finished
		tutorial_sprite.texture = load(tutorial_data[index]["image_path"])
		if current_step == tutorial_data.size() - 1:
			# shows start button to start game
			start_button.show()
			$CanvasLayer/ClickToContinueLabel.hide()
		tutorial_label.text = tutorial_data[index]["text"]
		await fade.fade(0, 0.2).finished
	else:
		# just load it without tweeners
		tutorial_label.text = tutorial_data[index]["text"]
		tutorial_sprite.texture = load(tutorial_data[index]["image_path"])

func _on_start_button_pressed() -> void:
	await fade.fade(1, 2.0).finished
	print("Starting game, from tutorial cutscene")
	get_tree().change_scene_to_packed(Global.GAME)
