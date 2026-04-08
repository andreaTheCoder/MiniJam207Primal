extends Sprite2D

class_name Potion

const DEFAULT_POTION_COLOR = Color.SKY_BLUE
const POTION_HOME = Vector2(0,80)

@onready var potion_liquid: Sprite2D = $"Potion Liquid"

@export var ingredients := []
@export var is_touching_mouse := false
@export var is_inside_tray := false
@export var total_liquid_color = DEFAULT_POTION_COLOR

func _ready() -> void:
	reset_liquid_color()
	position = POTION_HOME
	texture = preload("res://art/Empty Bottle.png")
	Global.potion = self

func _process(_delta: float) -> void:
	# If mouse is not dragging item, just clicked and is_touching_mouse (mouse inside bottle area2d), then drag 
	if Global.mouse_dragging_item == null and Input.is_action_just_pressed("click") and is_touching_mouse:
		Global.mouse_dragging_item = self
	# while it's being dragged set position to mouse position
	elif Global.mouse_dragging_item == self and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	elif Global.mouse_dragging_item == self and Input.is_action_just_released("click"):
			# released inside tray
			if is_inside_tray:
				# resets potion
				reset_liquid_color()
				EventBus.potion_submitted.emit(self, ingredients)
			# resets potion location
			Global.mouse_dragging_item = null
			global_position = POTION_HOME

func reset_liquid_color():
	potion_liquid.modulate = DEFAULT_POTION_COLOR

func change_liquid_color(color_to_mix : Color):
	if ingredients.size() == 1:
		total_liquid_color = color_to_mix
	else:
		total_liquid_color += color_to_mix
	potion_liquid.modulate = total_liquid_color/ingredients.size()

func _on_area_2d_mouse_entered() -> void:
	scale = Global.SCALE_SIZE
	is_touching_mouse = true

func _on_area_2d_mouse_exited() -> void:
	scale = Global.DEFAULT_SIZE
	is_touching_mouse = false

# TODO: handle this logic in tray.gd
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Tray:
		is_inside_tray = true
		area.get_parent().scale = Global.SCALE_SIZE
		area.get_parent().modulate = Color.GREEN_YELLOW

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Tray:
		is_inside_tray = false
		area.get_parent().scale = Global.DEFAULT_SIZE
		area.get_parent().modulate = Color.WHITE
