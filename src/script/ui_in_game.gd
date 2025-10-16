extends CanvasLayer

@onready var ui_main=$Panel
@onready var ui_setting=$setting_ui
@onready var ui_restart=$TextureButton
@onready var gd_main=$"../.."#主界面
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_restart.visible=false
	ui_main.visible=false
	ui_setting.visible=false
	get_tree().paused=false
	gd_main.game_initialized.connect(initial_game)
	
func initial_game()->void:
	if GameState.state==GameState.PLAYING:
		ui_restart.visible=true
		

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


func _on_continue_pressed() -> void:
	ui_main.visible=false
	get_tree().paused=false # Replace with function body.


func _on_setting_pressed() -> void:
	ui_main.visible=false# Replace with function body.
	ui_setting.visible=true


func _on_return_pressed() -> void:
	ui_main.visible=true# Replace with function body.
	ui_setting.visible=false



func _on_texture_button_pressed() -> void:
	get_tree().paused = false
	var new_scene = preload("res://scenes/levels/level_0.tscn").instantiate()
	var parent = get_tree().root
	parent.add_child(new_scene)

	# 删除旧场景（假设这是暂停菜单里的按钮）
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene
