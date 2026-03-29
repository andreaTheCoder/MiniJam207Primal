extends Sprite2D

class_name Tray
@export var area_ref = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.potion_submitted.connect(potion_submit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func potion_submit(potionparam, ingredients):
	if not Global.orders.any(func(x):return (x.potion["ingredients"].size() == ingredients.size())):
		potionparam.ingredients.clear()
		return
	else:
		var i = 0
		for orders in Global.orders:
			var tempPotionIngredients = orders.potion["ingredients"]
			var tempIngredients = ingredients.duplicate()
			if sort_enum_return_as_ints(tempIngredients) == sort_enum_return_as_ints(tempPotionIngredients):
				print("omg your order is valid bro")
				print(Global.orders)
				var temp = orders
				Global.orders.remove_at(i)
				temp.queue_free()
				potionparam.ingredients.clear()
				if Global.orders == []:
					EventBus.out_of_tickets.emit()
				return
			i+=1
		potionparam.ingredients.clear()
func sort_enum_return_as_ints(arr ):
	var tempArray := []
	for ingredient in arr:
		var index : int = ingredient
		tempArray.append(index)
	tempArray.sort()
	return tempArray	

	
