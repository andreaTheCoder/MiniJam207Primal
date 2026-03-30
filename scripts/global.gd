extends Node

const SHOP = preload("res://scenes/shop.tscn")
enum INGREDIENTS
{
	FAIRY_WINGS,
	ALLIGATOR_TEARS,
	DRIED_BLURPLEBERRY,
	DRAGONS_BREATH
}	
const START_TIME = 12
const END_TIME = 24
const END_DAY = 7
@export var day := 1
@export var time := START_TIME
@export var score := 0
var orders = []
const POTION_HOME = Vector2(0,80)
var mouse_dragging_item = null
var potion
var customer_happiness := true
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
	"ingredients" : [INGREDIENTS.ALLIGATOR_TEARS, INGREDIENTS.DRIED_BLURPLEBERRY],
	"name" : "Home Brew"
}
const SILLY_SMOOTHIE = {
	"ingredients" : [INGREDIENTS.DRIED_BLURPLEBERRY, INGREDIENTS.FAIRY_WINGS],
	"name" : "Silly Smoothie"
}
const POTION_OF_TATTLE = {
	"ingredients" : [INGREDIENTS.DRAGONS_BREATH, INGREDIENTS.FAIRY_WINGS],
	"name" : "Potion of Tattle"
}
const STINK_BOMB = {
	"ingredients" : [INGREDIENTS.DRAGONS_BREATH, INGREDIENTS.DRIED_BLURPLEBERRY],
	"name" : "Stink Bomb"
}
const BLURPLE_JUICE = {
	"ingredients" : [INGREDIENTS.DRIED_BLURPLEBERRY, INGREDIENTS.DRIED_BLURPLEBERRY, INGREDIENTS.DRIED_BLURPLEBERRY],
	"name" : "Blurple Juice"
}
const POTION_OF_HEEL = {
	"ingredients" : [INGREDIENTS.ALLIGATOR_TEARS, INGREDIENTS.DRIED_BLURPLEBERRY, INGREDIENTS.FAIRY_WINGS],
	"name" : "Potion of Heel"
}
const POISONOUS_POISON = {
	"ingredients" : [INGREDIENTS.ALLIGATOR_TEARS, INGREDIENTS.ALLIGATOR_TEARS, INGREDIENTS.DRAGONS_BREATH],
	"name" : "Poisonous Poison"
}
const MELANCHOLY_SLURPEE = {
	"ingredients" : [INGREDIENTS.ALLIGATOR_TEARS, INGREDIENTS.ALLIGATOR_TEARS, INGREDIENTS.ALLIGATOR_TEARS],
	"name" : "Melancholy Slurpee"
}
const THE_FORBIDDEN_MIXTURE = {
	"ingredients" : [INGREDIENTS.DRIED_BLURPLEBERRY, INGREDIENTS.FAIRY_WINGS, INGREDIENTS.ALLIGATOR_TEARS, INGREDIENTS.DRAGONS_BREATH],
	"name" : "Forbidden Mixture"
}
const POTIONS := [HOME_BREW, BLURPLE_JUICE, POTION_OF_HEEL, POISONOUS_POISON, POTION_OF_TATTLE, MELANCHOLY_SLURPEE, SILLY_SMOOTHIE, THE_FORBIDDEN_MIXTURE]
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
