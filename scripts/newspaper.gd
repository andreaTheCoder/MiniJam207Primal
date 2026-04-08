extends TextureRect

var image = "res://art/News " + str(Global.day) + ".png"

func _ready() -> void:
	EventBus.day_end.connect(_newspaper_update)
	top_level = true
	texture = load(image) 

func _newspaper_update():
	image = "res://art/News " + str(Global.day) + ".png"
	texture = load(image)
