extends Area2D

var is_clicked = false
onready var t_chat = get_parent().get_node("TraderChat")
onready var chat_timer = get_parent().get_node("TraderChat/ChatTimer")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_RIGHT \
	and event.is_pressed():
		self.on_click()

func on_click():
	print("Click")
	reply()

func reply():
	# Add actual reply as a label
	var replies = ["What're you buyin'?", "...", "You need something?", 
	"I'm coded so well"]
	randomize()
	t_chat.show()
	t_chat.text = replies[randi()%replies.size()]
	chat_timer.wait_time = 5
	chat_timer.start()

func _on_ChatTimer_timeout():
	t_chat.hide()
