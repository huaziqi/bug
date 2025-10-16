extends CanvasLayer

@onready var ui_main=$NinePatchRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Replace with function body.
	#GameState.state=GameState.PLAYING
	ui_main.visible=false
	get_tree().paused=false

func _input(event):
	# 检查是否是您定义的动作按下事件
	if event.is_action_pressed("menu") and GameState.state==GameState.PLAYING:
		print("pressed")
		# 立即标记事件为已处理
	#	get_tree().set_input_as_handled()
		if get_tree().paused==true:
			# 如果游戏暂停，则恢
			get_tree().paused = false
			ui_main.visible=false
			# 隐藏暂停菜单
			# $PauseMenu.hide()
		else:
			# 如果游戏未暂停，则暂停
			get_tree().paused = true
			ui_main.visible=true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_quit_pressed() -> void:

	get_tree().quit() # Replace with function body.
