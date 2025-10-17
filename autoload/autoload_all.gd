extends Node

enum { TITLE, PLAYING, PAUSED }
var state:int = TITLE
signal game_initialized
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
