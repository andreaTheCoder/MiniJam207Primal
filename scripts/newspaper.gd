extends TextureRect

var image = "res://art/News " + str(Global.day) + ".png"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	EventBus.day_end.connect(_newspaper_update)
	top_level = true
	texture = load(image) 


func _process(_delta: float) -> void:
	pass

func _newspaper_update():
	image = "res://art/News " + str(Global.day) + ".png"
	texture = load(image)
