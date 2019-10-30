extends DialogType

onready var timer = $Timer

func start():
	view.set_text("...")
	view.show_full_text()
	view.show()
	timer.wait_time = info.wait
	timer.start()

func _on_Timer_timeout() -> void:
	finish(info.next)