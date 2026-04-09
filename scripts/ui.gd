extends CanvasLayer

const TICKET_PANEL: PackedScene = preload("res://scenes/ticket_panel.tscn")
const NEWS: PackedScene = preload("res://scenes/news.tscn")
const CUSTOMER_TEXT : PackedScene = preload("res://scenes/customer_text.tscn")

@onready var time_label: RichTextLabel = $"Time Label"
@onready var day_label: RichTextLabel = $"Day Label"
@onready var score_label: RichTextLabel = $"Score Label"
@onready var text_bubble_container: VBoxContainer = $VerticalTextBubbleContainer
@onready var fade: CanvasLayer = $Fade
@onready var newspaper_ref: TextureRect = $"Fade/newspaper"

func _ready() -> void:
	AudioPlayer.play_music(AudioPlayer.GAME_BGM, 1, true)
	EventBus.create_tickets.connect(_create_tickets)
	EventBus.add_customer_text.connect(_add_customer_text)
	EventBus.score_change.connect(_score_change)
	newspaper_ref.modulate.a = 0
	set_time_text() 
	set_day_text()

func _create_tickets():
	for i in range(3):
		var temp = TICKET_PANEL.instantiate()
		$MarginContainer/HorizontalTicketContainer.add_child(temp)

func _add_customer_text():
	var ct = CUSTOMER_TEXT.instantiate()
	text_bubble_container.add_child(ct)

func _score_change(order_size):
	Global.score += order_size*100
	set_score_text()

func _on_timer_timeout() -> void:
	if Global.time < Global.END_TIME:
		Global.time += 1
		set_time_text()
		if Global.time >= Global.END_TIME:
			a_new_day()

func set_score_text():
	var score_text = "Score: " + str(Global.score)
	score_label.text = score_text

func set_time_text():
	var time_text
	if Global.Hour_Clock_24:
		if Global.time%12 == 0:
			time_text = str(12)
		else:
			time_text = str(Global.time%12)
		time_text += ":00 "
		if Global.time > 11 and Global.time < 24:
			time_text += "PM"
		else:
			time_text += "AM"
	else:
		time_text = str(Global.time) + ":00"
	time_label.text = time_text

func set_day_text():
	var day_text = "Day: " + str(Global.day)
	day_label.text = day_text

# connected to ontimertimeout
func a_new_day():
	await fade.fade(1, 1.5).finished
	if Global.day < Global.END_DAY:
		EventBus.day_end.emit()
		clear_and_create_orders()
		
		# fade newspaper in
		var tweener = get_tree().create_tween()
		await tweener.tween_property(newspaper_ref, "modulate:a", 1, 1).finished
		await get_tree().create_timer(3).timeout
		
		Global.day += 1
		set_day_text()
		Global.time = Global.START_TIME
		set_time_text()
	else:
		get_tree().change_scene_to_packed(NEWS)
		return
		
	# fade it out
	var news_tweener = get_tree().create_tween()
	news_tweener.tween_property(newspaper_ref, "modulate:a", 0, 2)
	await fade.fade(0, 2.5).finished

func clear_and_create_orders():
	for orders in Global.orders:
		orders.queue_free()
	Global.orders.clear()
	Global.potion.ingredients.clear()
	EventBus.create_tickets.emit()
