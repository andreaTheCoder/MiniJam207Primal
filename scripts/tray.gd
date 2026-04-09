extends Sprite2D

class_name Tray

@export var area_ref = null

func _ready() -> void:
	EventBus.potion_submitted.connect(potion_submit)

func potion_submit(ingredients):
	if not Global.orders.any(func(x):return (x.potion["ingredients"].size() == ingredients.size())):
		Global.potion.ingredients.clear()
	else:
		var ingredient_position = 0
		for orders in Global.orders:
			var tempPotionIngredients = orders.potion["ingredients"]
			var tempIngredients = ingredients.duplicate()
			if sort_enum_return_as_ints(tempIngredients) == sort_enum_return_as_ints(tempPotionIngredients):
				var temp = orders
				EventBus.score_change.emit(tempIngredients.size())
				Global.orders.remove_at(ingredient_position)
				temp.queue_free()
				if Global.orders == []:
					EventBus.create_tickets.emit()
				Global.potion.ingredients.clear()
				Global.customer_happiness = true
				EventBus.add_customer_text.emit()
				AudioPlayer.play_sfx(AudioPlayer.CONFIRMATION, 1.25)
				return
			ingredient_position += 1
	Global.potion.ingredients.clear()
	Global.customer_happiness = false
	EventBus.add_customer_text.emit()
	AudioPlayer.play_sfx(AudioPlayer.ERROR)

func sort_enum_return_as_ints(arr):
	var tempArray := []
	for ingredient in arr:
		var index : int = ingredient
		tempArray.append(index)
	tempArray.sort()
	return tempArray
