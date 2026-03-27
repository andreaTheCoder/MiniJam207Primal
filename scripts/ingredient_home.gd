extends Area2D

class_name IngredientHome

const INGREDIENT = preload("res://scenes/ingredient.tscn")

@export var type : Global.INGREDIENTS
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_ingredient()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_ingredient():
	var temp = INGREDIENT.instantiate()
	temp.type = self.type
	add_child(temp)
	
