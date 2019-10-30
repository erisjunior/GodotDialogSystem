extends DialogType

onready var timer = $Timer

var message
var currentMessage = 0

func start():
	message = info.messages
	set_message_index(0)
	view.show()

func input(event: InputEvent) -> void:
	if is_mouse_button_pressed(event):
		if is_message_fully_visible():
			if currentMessage + 1 == message.size():
				if info.has('next'):
					finish(info.next)
				else:
					finish()
			else:
				show_next_message()
		else:
			show_complete_message()

func show_next_message():
	set_message_index(currentMessage + 1)

func is_mouse_button_pressed(event):
	return event is InputEventMouseButton and event.is_pressed()

func message_length():
	return message[currentMessage].length()

func show_complete_message():
	view.set_visible_characters(message_length())

func set_message_index(index) -> void:
	if index < 0 or index >= message.size():
		return
	currentMessage = index
	view.set_text(message[index])
	view.set_visible_characters(0)
	timer.start()

func is_message_fully_visible() -> bool:
	return view.get_visible_characters() >= message_length()

func _on_Timer_timeout() -> void:
	view.set_visible_characters(view.get_visible_characters() + 1)
