extends CanvasLayer
@onready var time_label: RichTextLabel = $"Time Label"
@onready var day_label: RichTextLabel = $"Day Label"
@onready var score_label: RichTextLabel = $"Score Label"
const TICKET_PANEL: PackedScene = preload("res://scenes/ticket_panel.tscn")
const NEWS: PackedScene = preload("res://scenes/news.tscn")
const CUSTOMER_TEXT : PackedScene = preload("res://scenes/customer_text.tscn")
@onready var text_bubble_container: VBoxContainer = $VerticalTextBubbleContainer
@onready var fade: CanvasLayer = $Fade
const START_TIME = 12
const END_TIME = 24
const END_DAY = 7
@export var time := START_TIME
@export var score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.out_of_tickets.connect(_out_of_tickets)
	EventBus.add_customer_text.connect(_add_customer_text)
	EventBus.score_change.connect(_score_change)
	set_time()
	set_day()

func _out_of_tickets():
	for i in range(3):
		var temp = TICKET_PANEL.instantiate()
		$MarginContainer/HorizontalTicketContainer.add_child(temp)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _add_customer_text():
	var ct = CUSTOMER_TEXT.instantiate()
	text_bubble_container.add_child(ct)
	
func _score_change(order_size):
	score += order_size*100
	set_score()

	
	

func _on_timer_timeout() -> void:
	if time < END_TIME:
		time += 1
		set_time()
	else:
		a_new_day()

func set_score():
	var score_text = "Score: " + str(score)
	score_label.text = score_text

func set_time():
	var time_text = "Time: " + str(time) + ":00"
	time_label.text = time_text

func set_day():
	var day_text = "Day: " + str(Global.day)
	day_label.text = day_text

func a_new_day():
	await fade.fade(1, 2.5).finished
	if Global.day < END_DAY:
		time = START_TIME
		set_time()
		Global.day += 1
		set_day()
		Global.potion.potion_liquid.hide()
		for orders in Global.orders:
			orders.queue_free()
		Global.orders.clear()
		Global.potion.ingredients.clear()
		EventBus.out_of_tickets.emit()
	else:
		get_tree().change_scene_to_packed(NEWS)
		return
	await fade.fade(0, 2.5).finished
