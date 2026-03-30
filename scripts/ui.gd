extends CanvasLayer
@onready var time_label: RichTextLabel = $"Time Label"
@onready var day_label: RichTextLabel = $"Day Label"
@onready var score_label: RichTextLabel = $"Score Label"
@onready var day_counter: RichTextLabel = $"Fade/Day Counter"
const TICKET_PANEL: PackedScene = preload("res://scenes/ticket_panel.tscn")
const NEWS: PackedScene = preload("res://scenes/news.tscn")
const CUSTOMER_TEXT : PackedScene = preload("res://scenes/customer_text.tscn")
@onready var text_bubble_container: VBoxContainer = $VerticalTextBubbleContainer
@onready var fade: CanvasLayer = $Fade
@export var newspaper_ref: Node2D
const BGM = preload("res://audio/tunetank-jazz-cafe-music-348267.mp3")

# Called when the node enters the scene tree for the first time.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	newspaper_ref.sprite.hide()
	AudioPlayer.play_music(BGM, -10, true)
	EventBus.out_of_tickets.connect(_out_of_tickets)
	EventBus.add_customer_text.connect(_add_customer_text)
	EventBus.score_change.connect(_score_change)
	day_counter.modulate.a = 0
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
	Global.score += order_size*100
	set_score()

	
	

func _on_timer_timeout() -> void:
	if Global.time < Global.END_TIME:
		Global.time += 1
		set_time()
		if Global.time >= 24:
			a_new_day()

func set_score():
	var score_text = "Score: " + str(Global.score)
	score_label.text = score_text

func set_time():
	var time_text = "Time: " + str(Global.time) + ":00"
	time_label.text = time_text

func set_day():
	var day_text = "Day: " + str(Global.day)
	day_label.text = day_text

func a_new_day():
	await fade.fade(1, 1.5).finished
	if Global.day < Global.END_DAY:
		Global.time = Global.START_TIME
		set_time()
		Global.day += 1
		set_day()
		Global.potion.potion_liquid.hide()
		for orders in Global.orders:
			orders.queue_free()
		Global.orders.clear()
		Global.potion.ingredients.clear()
		EventBus.out_of_tickets.emit()
		day_counter.show()
		day_counter.text = "Day: "
		day_counter.text += str(Global.day)
		newspaper_ref.sprite.show() 
		await get_tree().create_timer(5).timeout
		var tweener = get_tree().create_tween()
		await tweener.tween_property(day_counter, "modulate:a", 1, 2).finished
	else:
		get_tree().change_scene_to_packed(NEWS)
		return
	var tweener = get_tree().create_tween()
	tweener.tween_property(day_counter, "modulate:a", 0, 2.5)
	await fade.fade(0, 2.5).finished
