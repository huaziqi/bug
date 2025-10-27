extends CanvasLayer

@onready var ui_main=$Panel
#@onready var ui_setting=$setting_ui
@onready var ui_restart=$TextureButton
@onready var ui_terminal=$TextureButton2
@onready var first_input_instruction=$Panel/VBoxContainer/below_white_bar/MarginContainer/below_bar/initial_instruction
@onready var add_child_place=$Panel/VBoxContainer/below_white_bar/MarginContainer/below_bar
@onready var animate_ui=$Panel
@onready var load_timer=$"../load_timer"
const TRANSITION_SCENE = preload("uid://3guswm2uo0xu")


#var message_input=GameState.get_last_child_of_node(add_child_place).get_node("input_instruction").get_node("input").get_node("Label_player")
const Process_instruction_SCENE = preload("res://src/Scene/ui_loading_process.tscn")
const Input_instruction_SCENE = preload("res://src/Scene/initial_ui.tscn")
const Level_instruction_SCENE = preload("res://src/Scene/level_instruction.tscn")
const you_cannot_jump_SCENE=preload("res://src/Scene/ui_you_can_not_jump.tscn")
#状态
enum {UI_STATE_MAIN , UI_STATE_SETTING , UI_STATE_QUIT , UI_STATE_CONTINUE , UI_STATE_LEVEL, UI_STATE_RETURN , UI_STATE_JUMP}
var ui_state:int = UI_STATE_MAIN
#关卡相关
var where_to_go="1"
'''
var level_address_with_index={"1":"res://scenes/levels/level_0.tscn",
"2":"res://scenes/levels/level_10086.tscn",
"3":"res://scenes/levels/level_3.tscn",
"4":"res://scenes/levels/level_4.tscn",
"5":"res://scenes/levels/level_10087-1.tscn",
"6":"res://scenes/levels/level_10087.tscn",
"7":"res://scenes/levels/level_10088.tscn",
"8":"res://scenes/levels/level_100810.tscn",
"9":"res://scenes/levels/level_2.tscn",
"0":"res://scenes/levels/level_1.tscn",
#"?":"res://scenes/levels/level_10089.tscn",
"E":"res://scenes/levels/level_10089.tscn"}
'''
#加载动画相关
const time_change=[2,2,2]
const basic_time_gap=0.05
var time_change_counter=0
var time_array_l=time_change.size()


func _ready() -> void:
	ui_restart.focus_mode = Control.FOCUS_NONE
	process_mode = Node.PROCESS_MODE_ALWAYS
	ui_restart.visible=false
	ui_main.visible=false
	#ui_setting.visible=false
	get_tree().paused=false
	GameState.game_initialized.connect(initial_game)
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
	if event.is_action_pressed("menu") and (GameState.state==GameState.PLAYING or GameState.state==GameState.PAUSED):
		#print("pressed")
		# 立即标记事件为已处理
	#	get_tree().set_input_as_handled()
		if get_tree().paused==true:
			# 如果游戏暂停，则恢
			ui_hide()
			#ui_level.visible=false
		
		else:
			# 如果游戏未暂停，则暂停
			ui_out()
	
	#enter输入
func _unhandled_input(event):
	if GameState.get_last_child_of_node(add_child_place)==null:
		return
	if GameState.get_last_child_of_node(add_child_place).get_node("input_instruction")==null:
		return
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
		#level选关卡
		elif ui_state==UI_STATE_LEVEL:
			if event.is_action_pressed("ui_input_return"):
				message_input.text="R"
				ui_state=UI_STATE_RETURN
				
			for i in range(0,10):
				var add_n_value=str(i)
				if event.is_action_pressed(add_n_value):
					message_input.text=add_n_value
					ui_state=UI_STATE_JUMP
					where_to_go=add_n_value
					
			
			if event.is_action_pressed("END"):
				message_input.text="E"
				where_to_go="E"
				ui_state=UI_STATE_JUMP
			
		
				
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
			elif ui_state==UI_STATE_JUMP:
				
				if GameState.level_address_with_index[where_to_go]==null:
					print("you have no right")
					var new_cannot_jump_dode=you_cannot_jump_SCENE.instantiate()
					add_child_place.add_child(new_cannot_jump_dode)	
					await get_tree().create_timer(3).timeout
					add_main_ui()
				else:
					add_loading_process()
					await get_tree().create_timer(3.5).timeout
					_on_jump_pressed()
					ui_hide()
					add_main_ui()
				ui_state=UI_STATE_MAIN
			elif ui_state==UI_STATE_MAIN:
				add_main_ui()
				
		delete_overflow_cmd()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func add_main_ui():
	var new_input_instruction_node=Input_instruction_SCENE.instantiate()
	get_off_cursor()
	if first_input_instruction!=null:#check null and delete selection
		if is_instance_valid(first_input_instruction.get_node("selections")):
			first_input_instruction.get_node("selections").queue_free()
			
	first_input_instruction=new_input_instruction_node
	add_child_place.add_child(new_input_instruction_node)

func _on_level_pressed() -> void:
	var new_level_instruction_node=Level_instruction_SCENE.instantiate()
	get_off_cursor()
	#if is_instance_valid(first_input_instruction.get_node("selections")):
		#first_input_instruction.get_node("selections").queue_free()
	if is_instance_valid(first_input_instruction.get_node("selection_level")):
		first_input_instruction.get_node("selection_level").queue_free()
		#pass
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
	var num = Dialogic.VAR.get_variable("interact_time")
	if(num >= 0):
		Dialogic.VAR.set_variable("interact_time", 0)
	get_tree().reload_current_scene()

func _on_texture_button_2_pressed() -> void:
	if GameState.state==GameState.PLAYING:
		ui_out()
		GameState.state=GameState.PAUSED
	elif GameState.state==GameState.PAUSED:
		ui_hide()

func _on_texture_button_bar_cross_pressed() -> void:
	get_tree().paused = false
	ui_main.visible=false

func _on_jump_pressed(): 
	print("去哪1")
	print(where_to_go)
	print(GameState.level_address_with_index[where_to_go])
	print("全部输出1")
	print(GameState.level_address_with_index)
	#if GameState.level_address_with_index[where_to_go]!=null:
	TransitionInfo.next_scene = load(GameState.level_address_with_index[where_to_go])
	get_tree().change_scene_to_packed(TRANSITION_SCENE)
	#get_tree().change_scene_to_file("res://scenes/levels/level_10086.tscn")
	#elif GameState.level_address_with_index[where_to_go]==null:	
		#var new_cannot_jump_dode=you_cannot_jump_SCENE.instantiate()
		#add_child_place.add_child(new_cannot_jump_dode)
	#ui_hide()

func delete_overflow_cmd():
	var child_count = add_child_place.get_child_count()
	if child_count>3:
		var first_child = add_child_place.get_child(0)
		first_child.queue_free()
		
func get_off_cursor():
	if first_input_instruction==null:
		return
	first_input_instruction.get_node("input_instruction").get_node("input").get_node("MarginContainer").queue_free()#去掉光标

func add_loading_process():
	load_timer.timeout.connect(_on_load_timer_timeout)#添加过程在链接的函数
	time_change_counter=0
	_execute_next_step()


func ui_out():
	GameState.state=GameState.PAUSED
	animate_ui.animate_in()
	get_tree().paused = true
	ui_main.visible=true
	
func ui_hide():
	GameState.state=GameState.PLAYING
	#animate_ui.animate_out()
	get_tree().paused = false
	ui_main.visible=false
	
func _on_load_timer_timeout() -> void:
	_execute_next_step()
	
func _execute_next_step():
	# 检查是否应该停止（相当于 while 循环的条件）
	#if time_change_counter >= 3:
		#load_timer.stop()
		#print("加载循环完成。")
		#ui_hide()
		#add_main_ui()
		#return
	await get_tree().create_timer(1.5).timeout
	var new_process_node=Process_instruction_SCENE.instantiate()
	add_child_place.add_child(new_process_node)
	#await get_tree().create_timer(1).timeout
	#add_main_ui()
	
	#load_timer.wait_time = time_change[time_change_counter ]
	#load_timer.start()
	GameState.loading_process_signal.emit(time_change_counter)
	#time_change_counter += 1
	delete_overflow_cmd()
	
	
