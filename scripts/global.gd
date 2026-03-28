extends Node

const SHOP = preload("res://scenes/shop.tscn")
enum INGREDIENTS
{
	FAIRY_WINGS,
	ALLIGATOR_TEARS,
	DRIED_BLURPLEBERRY,
	DRAGONS_BREATH
}	
var orders = []
const POTION_HOME = Vector2(0,-200)
var mouse_dragging_item = null

func tween_scale(target_scale : Vector2, object, ease_type : Tween.EaseType = Tween.EaseType.EASE_IN, duration : float = .1):
	'''
	enter num 0 - 1
	if the thing is at 0, 1 already it won't do anything
	'''
	if duration < 0:
		printerr("invalid duration, it's smaller than 0")
	var tweener = get_tree().create_tween()
	tweener.set_ease(ease_type)
	tweener.tween_property(object, "scale", target_scale, duration)
	return tweener
	
const HOME_BREW = {
	"ingredients" : [INGREDIENTS.FAIRY_WINGS, INGREDIENTS.DRIED_BLURPLEBERRY],
	"name" : "Home Brew"
}

func convert_ingredient_names(ingredient:INGREDIENTS):
	match ingredient:
		INGREDIENTS.FAIRY_WINGS:
			return "Fairy Wings"
		INGREDIENTS.ALLIGATOR_TEARS:
			return "Alligator Tears"
		INGREDIENTS.DRIED_BLURPLEBERRY:
			return "Dried Blurpleberry"
		INGREDIENTS.DRAGONS_BREATH:
			return "Dragon's Breath"
