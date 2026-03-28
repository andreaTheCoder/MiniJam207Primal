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

func tweened_disappear(object, ease_type : Tween.EaseType = Tween.EaseType.EASE_IN, duration : float = 1.5):
	if duration < 0:
		printerr("invalid duration, it's smaller than 0")
	var tweener = get_tree().create_tween()
	tweener.set_ease(ease_type)
	tweener.tween_property(object, "scale", Vector2(0,0), duration)
	return tweener
