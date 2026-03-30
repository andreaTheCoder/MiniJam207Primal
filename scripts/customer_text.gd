extends PanelContainer

@onready var customer_text: Label = $Panel/Label
const CUSTOMER_THANKS = [
	"Thank you, ",
	"Thanks, ",
	"Wowwzas, ",
	"Yippeee, ",
	"Awesome, ",
	"Hiya, "
]
const CUSTOMER_POTION_PREFIX = [
	"this ",
	"the ",
	"that ",
	"your "
]
const CUSTOMER_POTION_NAME = [
	"potion ",
	"elixir ",
	"drink ",
	"brew ",
	"concoction ",
	"mixture ",
	"magical liquid "
]
const CUSTOMER_SAYING = [
	"will be very useful for my evil plans",
	"will help my family immensely",
	"won't be used for any nefarious purpose",
	"will be used only for good, trust me",
	"has great potential for destruction",
	"could not be more fitting for what I've planned",
	"is going to help me 'take care' of my clients",
	"will help me seduce the rat love of my life",
	"is very helpful",
	"is great",
	"will be greatly appreciated by the cult"
]
const CUSTOMER_ENDING = [
	".",
	"!",
	"..."
]
const CUSTOMER_COMPLAINT_PREFIX = [
	"Hey, ",
	"Argh, ",
	"What, ",
	"Mate, ",
	"Watch it, ",
	"What is this, "
]
const CUSTOMER_COMPLAINT_SAYING = [
	"is not what any of us ordered",
	"has a terrible glisten to it",
	"is not on any of your tickets",
	"is so bad that no one here would ever drink that"
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate.a = 0
	if Global.customer_happiness:
		customer_text.text = CUSTOMER_THANKS.pick_random()
		customer_text.text += CUSTOMER_POTION_PREFIX.pick_random()
		customer_text.text += CUSTOMER_POTION_NAME.pick_random()
		customer_text.text += CUSTOMER_SAYING.pick_random()
		customer_text.text += CUSTOMER_ENDING.pick_random()
	else:
		customer_text.text = CUSTOMER_COMPLAINT_PREFIX.pick_random()
		customer_text.text += CUSTOMER_POTION_PREFIX.pick_random()
		customer_text.text += CUSTOMER_POTION_NAME.pick_random()
		customer_text.text += CUSTOMER_COMPLAINT_SAYING.pick_random()
		customer_text.text += CUSTOMER_ENDING.pick_random()
	var tweener = get_tree().create_tween()
	tweener.tween_property(self, "modulate:a", 1, 0.5)

func _on_timer_timeout() -> void:
	var tweener = get_tree().create_tween()
	await tweener.tween_property(self, "modulate:a", 0, 0.5).finished
	self.queue_free()
