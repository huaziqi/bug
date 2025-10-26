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
	#set_process_unhandled_input(false)
	var tree := get_tree()
	await TransitionUi.fade_to_black(0.2)
	TransitionInfo.next_scene = first_scene
	tree.change_scene_to_packed(TRANSITION_SCENE)
	#await get_tree().process_frame   # 可选：切完等一帧更稳
	await TransitionUi.fade_from_black(0.2)



	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()
	
	print("GAMEstart")


func end_back_to_main(): #从结尾回来的函数，连个结尾的信号
	$sound_end_back_to_main.play()
	
# 把这个函数放到任意脚本里（建议放到一个全局 Autoload 单例里用）
# 用法示例：
#   await scene_transition("res://scenes/MainMenu.tscn", "res://scenes/Level1.tscn")

# Godot 4.x
# 用法：
#   await scene_transition("res://scenes/MainMenu.tscn", "res://scenes/Level1.tscn")

# Godot 4.x 纯动画过场（不负责切场景）
