extends PanelContainer

const THANKS = [
	"Thank you, ",
	"Thanks, ",
	"Wowwzas, ",
	"Yippeee, ",
	"Awesome, ",
	"Hiya, "
]
const COMPLAINT = [
	"Hey, ",
	"Argh, ",
	"What, ",
	"Mate, ",
	"Watch it, ",
	"What is this, "
]
const POTION_PREFIX = [
	"this ",
	"the ",
	"that ",
	"your "
]
const POTION_ROOT = [
	"potion ",
	"elixir ",
	"drink ",
	"brew ",
	"concoction ",
	"mixture ",
	"magical liquid "
]
const THANKS_SAYING = [
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
const COMPLAINT_SAYING = [
	"is not what any of us ordered",
	"has a terrible glisten to it",
	"is not on any of your tickets",
	"is so bad that no one here would ever drink that"
]
const ENDING = [
	".",
	"!",
	"..."
]

@onready var customer_text: Label = $Panel/Label

func _ready() -> void:
	self.modulate.a = 0
	if Global.customer_happiness:
		customer_text.text = THANKS.pick_random() + POTION_PREFIX.pick_random() + POTION_ROOT.pick_random() + THANKS_SAYING.pick_random() + ENDING.pick_random()
	else:
		customer_text.text = COMPLAINT.pick_random() + POTION_PREFIX.pick_random() + POTION_ROOT.pick_random() + COMPLAINT_SAYING.pick_random() + ENDING.pick_random()
	var tweener = get_tree().create_tween()
	tweener.tween_property(self, "modulate:a", 1, 0.5)

func _on_timer_timeout() -> void:
	var tweener = get_tree().create_tween()
	await tweener.tween_property(self, "modulate:a", 0, 0.5).finished
	self.queue_free()
