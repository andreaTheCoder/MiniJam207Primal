extends Sprite2D

class_name Potion

@export var ingredients := []
@export var draggable := false
@export var is_inside_droppable := false
@onready var potion_liquid: Sprite2D = $"Potion Liquid"

const DEFAULT_LIQUID_COLOR : Color = Color.SKY_BLUE
const POTION_HOME = Vector2(0,80)


func _ready() -> void:
	reset_liquid_color()
	position = POTION_HOME
	texture = preload("res://art/Empty Bottle.png")
	Global.potion = self

func _process(_delta: float) -> void:
	# If mouse is not dragging item, just clicked and draggable (mouse inside bottle area2d), then drag 
	if Global.mouse_dragging_item == null and draggable and Input.is_action_just_pressed("click"):
		Global.mouse_dragging_item = self
	# while it's being dragged set position to mouse position
	if Global.mouse_dragging_item == self and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	else:
		# behavior when released
		if Input.is_action_just_released("click"):
			# released inside tray
			if is_inside_droppable:
				reset_liquid_color()
				EventBus.potion_submitted.emit(self, ingredients)
			# reset potion
			Global.mouse_dragging_item = null
			global_position = POTION_HOME

func reset_liquid_color():
	potion_liquid.modulate = DEFAULT_LIQUID_COLOR

func change_liquid_color(color_to_change_to : Color):
	potion_liquid.modulate = color_to_change_to

func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)
	draggable = true

func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(1.00, 1.00)
	draggable = false
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Tray:
		is_inside_droppable = true
		area.get_parent().scale = Vector2(1.05, 1.05)
		area.get_parent().modulate = Color(Color.GREEN_YELLOW, 1)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Tray:
		is_inside_droppable = false
		area.get_parent().scale = Vector2(1.00, 1.00)
		area.get_parent().modulate = Color(1.0, 1.0, 1.0, 1.0)
