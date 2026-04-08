extends PanelContainer

class_name order

@onready var ticket_label: Label = $"Panel/Label"

@export var potion = Global.POTIONS.pick_random()

func _ready() -> void:
	Global.orders.append(self)
	ticket_label.text = potion["name"] + ":\n"
	#makes sure that no extra commas
	var comma = false
	for ingedient_num in potion["ingredients"]:
		if comma:
			ticket_label.text += ", \n"
		ticket_label.text += Global.convert_ingredient_names(ingedient_num)
		comma = true
