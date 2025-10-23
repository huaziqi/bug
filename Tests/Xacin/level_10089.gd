extends LevelManager


# Called when the node enters the scene tree for the first time.
func _physics_process(_delta: float) -> void:
	$Line2D.points[0]=$fan.global_position
	$Line2D.points[1]=$button.global_position
