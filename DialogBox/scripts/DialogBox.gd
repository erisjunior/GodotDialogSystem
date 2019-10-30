extends Node2D

onready var text = $Background/Control/VBoxContainer/Text
onready var container = $Background/Control/VBoxContainer
onready var engine = $DialogEngine

export (String, FILE, "*.json") var dialog_path
signal dialog_finished

var buttons = []

func _ready():
	reset()
	engine.load_dialog(dialog_path)
	start()

func start():
	engine.start(self)

func add_button(text):
	var button = Button.new()
	button.text = text
	button.connect("pressed", self, "on_button_pressed", [buttons.size()])
	buttons.append(button)
	container.add_child(button)

func clear_buttons():
	for b in buttons:
		container.remove_child(b)
		b.disconnect("pressed", self, "on_button_pressed")
	buttons.clear()

func on_button_pressed(index):
	engine.on_button_pressed(index)

func reset():
	hide()
	clear_text()
	set_visible_characters(0)
	clear_buttons()

func set_text(txt):
	text.bbcode_text = txt

func get_text():
	return text.bbcode_text

func get_visible_characters():
	return text.visible_characters

func increment_visible_characters(count = 1):
	text.visible_characters += count

func set_visible_characters(count):
	text.visible_characters = count

func is_text_fully_visible():
	return text.visible_characters == -1 or text.visible_characters >= text.bbcode_text.length()

func show_full_text():
	text.visible_characters = text.bbcode_text.length()

func clear_text():
	text.bbcode_text = ""

func show():
	visible = true

func hide():
	visible = false

func _on_Dialog_dialog_finished():
	pass # Replace with function body.
