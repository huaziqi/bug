extends RigidBody2D
@export var breaked:bool=false
func _physics_process(_delta: float) -> void:
	global_rotation=0
	if not breaked:
		global_position=Vector2(726,350)
func breaking() -> void:
	breaked=true
