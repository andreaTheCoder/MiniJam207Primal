extends Sprite2D

class_name Potion

@export var ingredients := []
@export var draggable := false
@export var dragging := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = preload("res://stock/potionsotck.png")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (draggable or dragging) and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
		dragging = true	
	else:
		if not Input.is_action_pressed("click"):
			dragging = false
			global_position = Global.POTION_HOME
	
func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)
	draggable = true


func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(1.00, 1.00)
	draggable = false
	
