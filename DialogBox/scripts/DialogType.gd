extends Node
class_name DialogType

signal dialog_finished(nextId)

var view
var info

func init(view, info):
	self.view = view
	self.info = info

func start():
	pass

func update(delta):
	pass

func input(event):
	pass

func on_button_pressed(index):
	pass

func finish(nextId = null):
	emit_signal("dialog_finished", nextId)