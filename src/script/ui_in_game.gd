extends CanvasLayer

@onready var ui_main=$Panel
#@onready var ui_setting=$setting_ui
@onready var ui_restart=$TextureButton
@onready var first_input_instruction=$Panel/VBoxContainer/below_white_bar/MarginContainer/below_bar/initial_instruction
@onready var add_child_place=$Panel/VBoxContainer/below_white_bar/MarginContainer/below_bar
const Input_instruction_SCENE = preload("res://src/Scene/initial_ui.tscn")
const Level_instruction_SCENE = preload("res://src/Scene/level_instruction.tscn")
#状态
enum {UI_STATE_MAIN , UI_STATE_SETTING , UI_STATE_QUIT , UI_STATE_CONTINUE , UI_STATE_LEVEL, UI_STATE_RETURN}
var ui_state:int = UI_STATE_MAIN
#方便

func _ready() -> void:
	ui_restart.focus_mode = Control.FOCUS_NONE
	process_mode = Node.PROCESS_MODE_ALWAYS
	ui_restart.visible=false
	ui_main.visible=false
	#ui_setting.visible=false
	get_tree().paused=false
	GameState.game_initialized.connect(initial_game)
	GameState.state=GameState.PLAYING
	GameState.quit_ui.connect(_on_quit_pressed)
	GameState.continue_ui.connect(_on_continue_pressed)
	GameState.level_ui.connect(_on_level_pressed)
	
	
func initial_game()->void:
	if GameState.state==GameState.PLAYING:
		ui_restart.visible=true
		$"..".mouse_filter = Control.MOUSE_FILTER_STOP
func in_title()->void:
	if GameState.state==GameState.TITLE:
		$"..".mouse_filter = Control.MOUSE_FILTER_IGNORE

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
			#ui_level.visible=false
		
		else:
			# 如果游戏未暂停，则暂停
			get_tree().paused = true
			ui_main.visible=true
	
	#enter输入
func _unhandled_input(event):
	var message_input=GameState.get_last_child_of_node(add_child_place).get_node("input_instruction").get_node("input").get_node("Label_player")
	if ui_main.visible==true:
		#初始化暂停界面的输入
		if ui_state==UI_STATE_MAIN:
			if event.is_action_pressed("ui_input_q"):
				message_input.text="Q"	#add_child_place就是个面板
				ui_state=UI_STATE_QUIT
			elif event.is_action_pressed("ui_input_continue"):
				message_input.text="Y"
				ui_state=UI_STATE_CONTINUE
			elif event.is_action_pressed("ui_input_level"):
				message_input.text="L"
				ui_state=UI_STATE_LEVEL
		if ui_state==UI_STATE_LEVEL:
			if event.is_action_pressed("ui_input_return"):
				message_input.text="R"
				ui_state=UI_STATE_RETURN
				
		#按下enter后的反馈
		if event.is_action_pressed("in_ui_enter"):
		
			if ui_state==UI_STATE_QUIT:
				_on_quit_pressed()
				ui_state=UI_STATE_MAIN
			elif ui_state==UI_STATE_LEVEL:
				_on_level_pressed()
			elif ui_state==UI_STATE_RETURN:
				_on_return_pressed()
			elif ui_state==UI_STATE_CONTINUE:
				_on_continue_pressed()
				ui_state=UI_STATE_MAIN
				
			elif ui_state==UI_STATE_MAIN:
				add_main_ui()
				
			delete_overflow_cmd()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func add_main_ui():
	var new_input_instruction_node=Input_instruction_SCENE.instantiate()
	get_off_cursor()
	if is_instance_valid(first_input_instruction.get_node("selections")):
		first_input_instruction.get_node("selections").queue_free()
	if is_instance_valid(first_input_instruction.get_node("selection_level")):
		first_input_instruction.get_node("selection_level").queue_free()
	first_input_instruction=new_input_instruction_node
	add_child_place.add_child(new_input_instruction_node)

func _on_level_pressed() -> void:
	var new_level_instruction_node=Level_instruction_SCENE.instantiate()
	get_off_cursor()
	if is_instance_valid(first_input_instruction.get_node("selections")):
		first_input_instruction.get_node("selections").queue_free()
	if is_instance_valid(first_input_instruction.get_node("selection_level")):
		first_input_instruction.get_node("selection_level").queue_free()
	first_input_instruction=new_level_instruction_node
	add_child_place.add_child(new_level_instruction_node)
	

func _on_continue_pressed() -> void:
	ui_main.visible=false
	get_tree().paused=false # Replace with function body.
	
func _on_return_pressed() -> void:
	ui_state=UI_STATE_MAIN
	add_main_ui()

func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.

func _on_texture_button_pressed() -> void:
	get_tree().paused = false
	ui_main.visible=false
	get_tree().reload_current_scene()
	

	
	'''
	var new_scene = preload("res://scenes/levels/level_0.tscn").instantiate()
	var parent = get_tree().root
	parent.add_child(new_scene)
	

	# 删除旧场景（假设这是暂停菜单里的按钮）
	get_tree().current_scene.queue_free()
	get_tree().current_scene = new_scene
	'''


func _on_texture_button_bar_cross_pressed() -> void:
	get_tree().paused = false
	ui_main.visible=false


func delete_overflow_cmd():
	var child_count = add_child_place.get_child_count()
	if child_count>4:
		var first_child = add_child_place.get_child(0)
		first_child.queue_free()
		
func get_off_cursor():
	first_input_instruction.get_node("input_instruction").get_node("input").get_node("MarginContainer").queue_free()#去掉光标


	
