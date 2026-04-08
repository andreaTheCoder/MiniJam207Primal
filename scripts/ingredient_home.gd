extends Area2D

class_name IngredientHome

const INGREDIENT = preload("res://scenes/ingredient.tscn")

@export var has_ingredient := true
@export var type : Global.INGREDIENTS
@export var child_ref = null

func _process(_delta: float) -> void:
	if child_ref == null:
		spawn_ingredient()

func spawn_ingredient():
	var temp = INGREDIENT.instantiate()
	temp.type = self.type
	add_child(temp)
	temp.scale = Vector2(0,0)
	Global.tween_scale(Vector2(1,1), temp)
	child_ref = temp
