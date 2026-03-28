extends Node

const SHOP = preload("res://scenes/shop.tscn")
enum INGREDIENTS
{
	SHOEHORN_DUST,
	PIXELATED_DUCK_EXTRACT,
	DRIED_BLURPLEBERRY,
	ESSENCE_OF_GD_SCRIPT
}	

const POTION_HOME = Vector2(500,500)


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
