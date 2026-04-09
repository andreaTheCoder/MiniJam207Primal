extends Sprite2D

class_name Ingredient

@export var type: Global.INGREDIENTS
@export var is_touching_mouse := false
@export var is_inside_potion := false
@export var area_ref = null
@export var potion_tint : Color

func _ready() -> void:
	match type:
		Global.INGREDIENTS.FAIRY_WINGS:
			texture = load("res://art/fairy wings.PNG")
			potion_tint = Color.HOT_PINK
		Global.INGREDIENTS.ALLIGATOR_TEARS:
			texture = load("res://art/alligator tears.PNG")
			potion_tint = Color.WEB_GREEN
		Global.INGREDIENTS.DRIED_BLURPLEBERRY:
			texture = load("res://art/dried blurpleberry.PNG")
			potion_tint = Color.PURPLE
		Global.INGREDIENTS.DRAGONS_BREATH:
			texture = load("res://art/dragon's breath.PNG")
			potion_tint = Color.ORANGE

func _process(_delta: float) -> void:
	if Global.mouse_dragging_item == null and Input.is_action_just_pressed("click") and is_touching_mouse:
		Global.mouse_dragging_item = self
	elif Global.mouse_dragging_item == self and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	elif Global.mouse_dragging_item == self and Input.is_action_just_released("click"):
		if is_inside_potion:
			var random_pitch = randf_range(.5, 2)
			AudioPlayer.play_sfx(AudioPlayer.DROPPED_IN_POTION, 1, random_pitch)
			area_ref.ingredients.append(type)
			area_ref.modulate = Color.WHITE
			area_ref.change_liquid_color(potion_tint)
		Global.mouse_dragging_item = null
		await Global.tween_scale(Vector2(0,0),self).finished
		queue_free()

func _on_area_2d_mouse_entered() -> void:
	scale = Global.SCALE_SIZE
	is_touching_mouse = true

func _on_area_2d_mouse_exited() -> void:
	scale = Global.DEFAULT_SIZE
	is_touching_mouse = false

# if ingredient is in potion
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Potion:
		is_inside_potion = true
		area_ref = area.get_parent()
		area.get_parent().modulate = Color.GREEN_YELLOW
		area_ref.scale = Global.SCALE_SIZE
# if ingredient leaves potion
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Potion:
		is_inside_potion = false
		area.get_parent().modulate = Color.WHITE
		area_ref.scale = Global.DEFAULT_SIZE
