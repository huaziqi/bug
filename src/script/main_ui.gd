extends Control

const TRANSITION_SCENE = preload("uid://3guswm2uo0xu")

@export var first_scene : PackedScene

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
	TransitionInfo.next_scene = first_scene
	get_tree().change_scene_to_packed(TRANSITION_SCENE)
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()
	
	print("GAMEstart")


func end_back_to_main(): #从结尾回来的函数，连个结尾的信号
	$sound_end_back_to_main.play()
