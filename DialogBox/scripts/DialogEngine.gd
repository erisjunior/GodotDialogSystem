extends Node

var dialog
var dialogView
var currentNode = null

func start(dialogView):
	self.dialogView = dialogView
	assert dialog != null
	var first = dialog.start
	set_current_node(first)

func set_current_node(first):
	var info = dialog[first]
	assert info.has('type')
	assert has_node(info.type)
	currentNode = get_node(info.type)
	currentNode.connect("dialog_finished", self, "on_dialog_finished")
	currentNode.init(dialogView, info)
	currentNode.start()

func on_dialog_finished(nextId):
	dialogView.reset()
	currentNode.disconnect("dialog_finished", self, "on_dialog_finished")
	currentNode = null
	if nextId != null:
		set_current_node(nextId)
	else:
		dialogView.emit_signal("dialog_finished")

func _process(delta: float) -> void:
	if currentNode != null:
		currentNode.update(delta)

func _input(event: InputEvent) -> void:
	if currentNode != null:
		currentNode.input(event)

func on_button_pressed(index):
	if currentNode != null:
		currentNode.on_button_pressed(index)

func load_dialog(path):
	var file = File.new()
	assert file.file_exists(path)
	file.open(path, file.READ)
	var result = parse_json(file.get_as_text())
	assert result != null
	file.close()
	
	assert result.has("start")
	dialog = result