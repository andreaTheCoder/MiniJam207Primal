extends PanelContainer

class_name order

@export var potion = Global.HOME_BREW
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.orders.append(self)
	$Panel/Label.text = Global.HOME_BREW["name"]
	$Panel/Label.text += ":\n"
	#makes sure that no extra commas
	var i = true
	for ingedient_num in Global.HOME_BREW["ingredients"]:
		if not i:
			$Panel/Label.text += ", "
		$Panel/Label.text += Global.convert_ingredient_names(ingedient_num)
		i = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
