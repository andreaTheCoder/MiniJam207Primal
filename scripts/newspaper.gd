extends TextureRect

@export var image = "res://art/News 0.png"

func _ready() -> void:
	EventBus.day_end.connect(_newspaper_update)
	Global.newspaper = self
func _newspaper_update():
	image = "res://art/News " + str(Global.day) + ".png"
	texture = load(image)
