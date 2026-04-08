extends Sprite2D

class_name Tray
@export var area_ref = null

func _ready() -> void:
	EventBus.potion_submitted.connect(potion_submit)

func _process(_delta: float) -> void:
	pass

func potion_submit(potionparam, ingredients):
	if not Global.orders.any(func(x):return (x.potion["ingredients"].size() == ingredients.size())):
		potionparam.ingredients.clear()
	else:
		var i = 0
		for orders in Global.orders:
			var tempPotionIngredients = orders.potion["ingredients"]
			var tempIngredients = ingredients.duplicate()
			if sort_enum_return_as_ints(tempIngredients) == sort_enum_return_as_ints(tempPotionIngredients):
				print("omg your order is valid bro")
				print(Global.orders)
				var temp = orders
				EventBus.score_change.emit(tempIngredients.size())
				Global.orders.remove_at(i)
				temp.queue_free()
				potionparam.ingredients.clear()
				AudioPlayer.play_sfx(AudioPlayer.CONFIRMATION, 0)
				Global.customer_happiness = true
				EventBus.add_customer_text.emit()
				if Global.orders == []:
					EventBus.out_of_tickets.emit()
				return
			i+=1
		potionparam.ingredients.clear()
	Global.customer_happiness = false
	EventBus.add_customer_text.emit()
	order_fail(potionparam)

func order_fail(potion_ref):
	potion_ref.ingredients.clear()
	AudioPlayer.play_sfx(AudioPlayer.ERROR, 0)
	
func sort_enum_return_as_ints(arr ):
	var tempArray := []
	for ingredient in arr:
		var index : int = ingredient
		tempArray.append(index)
	tempArray.sort()
	return tempArray	
