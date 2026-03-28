extends Area2D

class_name IngredientHome

const INGREDIENT = preload("res://scenes/ingredient.tscn")

@export var type : Global.INGREDIENTS
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_ingredient()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn_ingredient():
	var temp = INGREDIENT.instantiate()
	temp.type = self.type
	add_child(temp)
	temp.scale = Vector2(0,0)
	Global.tween_scale(Vector2(1,1), temp)




func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Sprite2D:
		if not area.get_parent().leftHome and area.get_parent().type == self.type:
			call_deferred("spawn_ingredient")
		else:
			area.get_parent().leftHome = true
