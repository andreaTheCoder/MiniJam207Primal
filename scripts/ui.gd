extends CanvasLayer
@onready var time_label: RichTextLabel = $"Time Label"
@onready var day_label: RichTextLabel = $"Day Label"
@onready var score_label: RichTextLabel = $"Score Label"
const TICKET_PANEL: PackedScene = preload("res://scenes/ticket_panel.tscn")
const NEWS: PackedScene = preload("res://scenes/news.tscn")
const CUSTOMER_TEXT : PackedScene = preload("res://scenes/customer_text.tscn")
@onready var text_bubble_container: VBoxContainer = $VerticalTextBubbleContainer
@onready var fade: CanvasLayer = $Fade
@export var newspaper_ref: TextureRect
const BGM = preload("res://audio/tunetank-jazz-cafe-music-348267.mp3")

func _ready() -> void:
	AudioPlayer.play_music(BGM, -10, true)
	EventBus.out_of_tickets.connect(_out_of_tickets)
	EventBus.add_customer_text.connect(_add_customer_text)
	EventBus.score_change.connect(_score_change)
	newspaper_ref.modulate.a = 0
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
	var time_text = ""
	if Global.American:
		if Global.time%12 == 0:
			time_text += str(12)
		else:
			time_text += str(Global.time%12)
		time_text += ":00 "
		if Global.time > 11 and Global.time < 24:
			time_text += "PM"
		else:
			time_text += "AM"
	else:
		time_text += str(Global.time) + ":00"
	time_label.text = time_text

func set_day():
	var day_text = "Day: " + str(Global.day)
	day_label.text = day_text

func a_new_day():
	await fade.fade(1, 1.5).finished
	if Global.day < Global.END_DAY:
		EventBus.day_end.emit()
		clear_and_create_orders()
		var tweener = get_tree().create_tween()
		await tweener.tween_property(newspaper_ref, "modulate:a", 1, 1).finished
		await get_tree().create_timer(3).timeout
		Global.day += 1
		set_day()
		Global.time = Global.START_TIME
		set_time()
	else:
		get_tree().change_scene_to_packed(NEWS)
		return
	var thing_that_tweens = get_tree().create_tween()
	thing_that_tweens.tween_property(newspaper_ref, "modulate:a", 0, 2)
	await fade.fade(0, 2.5).finished

func clear_and_create_orders():
	Global.potion.potion_liquid.hide()
	for orders in Global.orders:
		orders.queue_free()
	Global.orders.clear()
	Global.potion.ingredients.clear()
	EventBus.out_of_tickets.emit()
