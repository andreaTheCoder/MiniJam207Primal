extends Sprite2D

class_name Tray
@export var area_ref = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.potion_submitted.connect(potion_submit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func potion_submit(ingredients):
	print("tray: ")
	print(ingredients)
