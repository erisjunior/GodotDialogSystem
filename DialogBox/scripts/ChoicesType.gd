extends DialogType

func start():
	view.set_text(info.question)
	for c in info.answers:
		view.add_button(c.text)
	
	view.show_full_text()
	view.show()

func on_button_pressed(index):
	var next = info.answers[index].next
	finish(next)