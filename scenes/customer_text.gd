extends PanelContainer

@onready var customer_text: ColorRect = $Panel/Label
var customer_thanks = [
	"Thank you, ",
	"Thanks, ",
	"Wowwzas, ",
	"Yippeee, ",
	"Awesome, ",
]
var customer_potion_prefix = [
	"this ",
	"the ",
	"that ",
	"your "
]
var customer_potion_name = [
	"potion ",
	"elixir ",
	"drink ",
	"brew ",
	"concoction ",
	"mixture "
]
var customer_saying = [
	"will be very useful for my evil plains",
	"will help my family immensely",
	"won't be used for any nefarious purpose",
	"will be used only for good, trust me",
	"has great potential for destruction",
	"could not be more fitting for what I've planned"
]
var customer_ending = [
	".",
	"!",
	"..."
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	customer_text.text = ""
	customer_text.text += ":\n"
	#makes sure that no extra commas
	var i = true
	for ingedient_num in "":
		if not i:
			customer_text.text += ", \n"
		customer_text.text += ""
		i = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
