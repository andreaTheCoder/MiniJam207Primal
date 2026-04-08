extends Sprite2D

class_name Potion
const DEFAULT_POTION_COLOR = Color.SKY_BLUE
@export var ingredients := []
@export var draggable := false
@export var dragging := false
@export var is_inside_droppable := false
@export var liquid_color = DEFAULT_POTION_COLOR
@onready var potion_liquid: Sprite2D = $"Potion Liquid"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_liquid_color()
	position = Global.POTION_HOME
	texture = preload("res://art/Empty Bottle.png")
	Global.potion = self
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.mouse_dragging_item == null and draggable and Input.is_action_just_pressed("click"):
		Global.mouse_dragging_item = self
		dragging = true
	if Global.mouse_dragging_item == self and dragging and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	else:
		if Input.is_action_just_released("click"):
			if is_inside_droppable:
					reset_liquid_color()
					EventBus.potion_submitted.emit(self, ingredients)
			Global.mouse_dragging_item = null
			dragging = false
			global_position = Global.POTION_HOME
			

func reset_liquid_color():
	liquid_color = DEFAULT_POTION_COLOR
	potion_liquid.modulate = liquid_color
	
func change_liquid_color(changed_color : Color):
	if ingredients.size() == 1:
		liquid_color = changed_color
	else:
		liquid_color += changed_color
	print(changed_color)
	print(liquid_color)
	potion_liquid.modulate = liquid_color/ingredients.size()

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
