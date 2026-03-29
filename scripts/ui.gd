extends CanvasLayer
@onready var time_label: RichTextLabel = $"Time Label"
const TICKET_PANEL: PackedScene = preload("res://scenes/ticket_panel.tscn")
const FADE = preload("res://scenes/fade.tscn")
@export var time := 12
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.out_of_tickets.connect(_out_of_tickets)
	set_time(time)

func _out_of_tickets():
	for i in range(3):
		var temp = TICKET_PANEL.instantiate()
		$MarginContainer/HorizontalTicketContainer.add_child(temp)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if (time < 20):
		time += 1
		set_time(time)
	else:
		var fade = FADE.instantiate()
		add_child(fade)
		await fade.fade(1, 1.0).finished
		fade.fade(0, 1.0).finished
		time = 12
func set_time(time):
	var time_text = "Time: " + str(time) + ":00"
	time_label.text = time_text
