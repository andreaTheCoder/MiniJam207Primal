extends Sprite2D

class_name Potion

@export var ingredients := []
@export var draggable := false
@export var dragging := false
@export var is_inside_droppable := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = preload("res://art/Empty Bottle.png")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Global.mouse_dragging_item == self or Global.mouse_dragging_item == null) and (draggable or dragging) and Input.is_action_pressed("click"):
		Global.mouse_dragging_item = self
		global_position = get_global_mouse_position()
		dragging = true	
	else:
		if Input.is_action_just_released("click"):
			if is_inside_droppable:
					EventBus.potion_submitted.emit(self, ingredients)
			Global.mouse_dragging_item = null
			dragging = false
			global_position = Global.POTION_HOME
			
	
func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)
	draggable = true


func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(1.00, 1.00)
	draggable = false
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Tray:
		is_inside_droppable = true
		area.get_parent().modulate = Color(Color.GREEN_YELLOW, 1)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Tray:
		is_inside_droppable = false
		area.get_parent().modulate = Color(1.0, 1.0, 1.0, 1.0)
