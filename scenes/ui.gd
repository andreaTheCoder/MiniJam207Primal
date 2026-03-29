extends CanvasLayer

const TICKET_PANEL: PackedScene = preload("res://scenes/ticket_panel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.out_of_tickets.connect(_out_of_tickets)

func _out_of_tickets():
	for i in range(3):
		var temp = TICKET_PANEL.instantiate()
		$MarginContainer/HorizontalTicketContainer.add_child(temp)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
