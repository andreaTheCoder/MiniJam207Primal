extends CanvasLayer
@onready var time_label: RichTextLabel = $"Time Label"
@onready var day_label: RichTextLabel = $"Day Label"
const TICKET_PANEL: PackedScene = preload("res://scenes/ticket_panel.tscn")
const NEWS: PackedScene = preload("res://scenes/news.tscn")
@onready var fade: CanvasLayer = $Fade
@export var time := 12
@export var day := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.out_of_tickets.connect(_out_of_tickets)
	set_time()
	set_day()

func _out_of_tickets():
	for i in range(3):
		var temp = TICKET_PANEL.instantiate()
		$MarginContainer/HorizontalTicketContainer.add_child(temp)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if time < 24:
		time += 1
		set_time()
	else:
		a_new_day()
func set_time():
	var time_text = "Time: " + str(time) + ":00"
	time_label.text = time_text

func set_day():
	var day_text = "Day: " + str(day)
	day_label.text = day_text

func a_new_day():
	await fade.fade(1, 1.0).finished
	if day < 7:
		time = 12
		day += 1
		set_day()
		for orders in Global.orders:
			orders.queue_free()
		Global.orders.clear()
		Global.potion.ingredients.clear()
		EventBus.out_of_tickets.emit()
	else:
		get_tree().change_scene_to_packed(NEWS)
		return
	await fade.fade(0, 1.0).finished
