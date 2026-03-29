extends Area2D

class_name IngredientHome

const INGREDIENT = preload("res://scenes/ingredient.tscn")
@export var has_ingredient := true
@export var type : Global.INGREDIENTS
var child_ref = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_ingredient()


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
