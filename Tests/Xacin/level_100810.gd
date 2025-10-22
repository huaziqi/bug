extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()#ui相关全局变量
	await get_tree().create_timer(1.0).timeout
	$AudioStreamPlayer2D.play()
	$camera.shake(5,2)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_flag_flag_up() -> void:
	$Steel_Pipe2.breaks()
