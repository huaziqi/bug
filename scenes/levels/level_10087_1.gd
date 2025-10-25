extends LevelManager
func _ready() -> void:
	$laser.r+=1
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("E"):
		get_tree().reload_current_scene()
