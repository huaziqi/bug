extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass# 标题页面时，防止ui干扰


func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventKey or 
		event is InputEventJoypadButton or 
		event is InputEventMouseButton )and(
		GameState.state==GameState.TITLE):
		if event.is_pressed():
			print(1)
			start_game()
		#	get_tree().set_input_as_handled() 

func start_game():
	set_process_unhandled_input(false)
	get_tree().change_scene_to_file("res://scenes/levels/level_0.tscn")
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()
	
	print("GAMEstart")


func end_back_to_main(): #从结尾回来的函数，连个结尾的信号
	$sound_end_back_to_main.play()
