extends Sprite2D

class_name Ingredient

@export var type : Global.INGREDIENTS
@export var draggable := false
@export var dragging := false
@export var leftHome := false
@export var is_inside_droppable := false
@export var area_ref = null
@export var potion_tint : Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		Global.INGREDIENTS.FAIRY_WINGS:
			texture = load("res://art/fairy wings.PNG")
			potion_tint = Color.HOT_PINK
		Global.INGREDIENTS.ALLIGATOR_TEARS:
			texture = load("res://art/alligator tears.PNG")
			potion_tint = Color.WEB_GREEN
		Global.INGREDIENTS.DRIED_BLURPLEBERRY:
			texture = load("res://art/blurpleberry.PNG")
			potion_tint = Color.PURPLE
		Global.INGREDIENTS.DRAGONS_BREATH:
			texture = load("res://art/dragon's breath.PNG")
			potion_tint = Color.ORANGE
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.mouse_dragging_item == null and draggable and Input.is_action_just_pressed("click"):
		Global.mouse_dragging_item = self
		dragging = true
	if Global.mouse_dragging_item == self and dragging and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	else:
		if Input.is_action_just_released("click"):
			if dragging:
				dragging = false
				if is_inside_droppable:
					var random_pitch = randf_range(.5, 2)
					AudioPlayer.play_sfx(AudioPlayer.DROPPED_IN_POTION, 0, random_pitch)
					area_ref.ingredients.append(type)
					area_ref.modulate = Color(1.0, 1.0, 1.0, 1.0)
					area_ref.change_liquid_color(potion_tint)
				Global.mouse_dragging_item = null
				await Global.tween_scale(Vector2(0,0),self).finished
				queue_free()

func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(1.05, 1.05)
	draggable = true

func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(1.00, 1.00)
	draggable = false




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Potion and dragging:
		is_inside_droppable = true
		area_ref = area.get_parent()
		area.get_parent().modulate = Color(Color.GREEN_YELLOW, 1)
		area_ref.scale = Vector2(1.05, 1.05)
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Potion and dragging:
		is_inside_droppable = false
		area.get_parent().modulate = Color(1.0, 1.0, 1.0, 1.0)
			
		area_ref.scale = Vector2(1.00, 1.00)
