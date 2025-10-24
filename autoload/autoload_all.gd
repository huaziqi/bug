extends Node

enum { TITLE, PLAYING, PAUSED }
var state:int = TITLE
signal game_initialized

signal quit_ui
signal continue_ui
signal setting_ui


func _on_continue_pressed() -> void:
	continue_ui.emit()


func _on_setting_pressed() -> void:
	setting_ui.emit()


func _on_select_level_pressed() -> void:
	pass # Replace with function body.


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
