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
