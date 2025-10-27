extends Node

enum { TITLE, PLAYING, PAUSED }
var state:int = TITLE
signal game_initialized

signal quit_ui
signal continue_ui
signal level_ui
signal loading_process_signal(time_change_count:int)
var level_address_with_index={"1":"res://scenes/levels/level_0.tscn","2":null,#10086
"3":null,#3
"4":null,#4
"5":null,#10087-1
"6":null,#10087
"7":null,#10088
"8":null,#100810
"9":null,#2
"0":null,#1
#"?":"res://scenes/levels/level_10089.tscn",
"E":null}#10089


func _ready() -> void:
	Config._load()
	if(Config.access_levels):
		level_address_with_index = Config.access_levels

func _on_continue_pressed() -> void:
	continue_ui.emit()


func _on_level_pressed() -> void:
	level_ui.emit()



func _on_quit_pressed() -> void:
	quit_ui.emit()


#@onready var ui_restart=$TextureButton
func state_repair():
	if GameState.state==GameState.PLAYING:
		game_initialized.emit()
'''
func initial_game()->void:
	if GameState.state==GameState.PLAYING:
		ui_restart.visible=true
		$"..".mouse_filter = Control.MOUSE_FILTER_STOP
		'''
func get_last_child_of_node(node: Node) -> Node:
	if not is_instance_valid(node):
		print("错误：传入的节点参数是无效或为空值。")
		return null
	# 1. 获取子节点的总数
	var child_count = node.get_child_count()
	
	# 2. 检查是否有子节点
	if child_count == 0:
		return null # 没有子节点，返回 null
	
	# 3. 计算最后一位的索引 (索引从 0 开始，所以是 count - 1)
	var last_index = child_count - 1
	
	# 4. 使用 get_child() 获取节点
	var last_child = node.get_child(last_index)
	
	return last_child
