extends Sprite2D

class_name Ingredient

@export var type : Global.INGREDIENTS
@export var draggable := false
@export var dragging := false
@export var leftHome :=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = preload("res://stock/input-prompts/Flair Icons/controller_battery_full.svg")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if (draggable or dragging) and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
		dragging = true	
	else:
		if not Input.is_action_pressed("click"):
			if dragging:
				await Global.tween_scale(Vector2(0,0),self).finished
				queue_free()
			dragging = false
func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)
	draggable = true

func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(1.00, 1.00)
	draggable = false
