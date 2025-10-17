extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()#ui相关全局变量
