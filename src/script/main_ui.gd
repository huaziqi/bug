extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ui.mouse_filter = Control.MOUSE_FILTER_IGNORE# 标题页面时，防止ui干扰


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.
	
func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventKey or 
		event is InputEventJoypadButton or 
		event is InputEventMouseButton )and(
		GameState.state==GameState.TITLE):
		if event.is_pressed():
			start_game()
		#	get_tree().set_input_as_handled() 

func start_game():
	set_process_unhandled_input(false)
	var packed_scene = preload("res://scenes/levels/level_0.tscn")
	var instance = packed_scene.instantiate()             # 实例化
	add_child(instance) 
	$MarginContainer.free()
	GameState.state=GameState.PLAYING
	$ui.mouse_filter = Control.MOUSE_FILTER_STOP #回复ui
