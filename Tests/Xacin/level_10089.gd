extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state=GameState.PLAYING
	GameState.game_initialized.emit()#ui相关全局变量

func _physics_process(_delta: float) -> void:
	$Line2D.points[0]=$fan.global_position
	$Line2D.points[1]=$button.global_position
