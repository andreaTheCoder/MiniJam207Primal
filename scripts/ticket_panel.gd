extends PanelContainer

class_name order

@export var potion = Global.POTIONS.pick_random()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.orders.append(self)
	$Panel/Label.text = potion["name"]
	$Panel/Label.text += ":\n"
	#makes sure that no extra commas
	var i = true
	for ingedient_num in potion["ingredients"]:
		if not i:
			$Panel/Label.text += ", \n"
		$Panel/Label.text += Global.convert_ingredient_names(ingedient_num)
		i = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
