extends RigidBody2D
signal flag_up #旗子被拔起来的信号
@export var breaked:bool=false
@export var is_being_breaked=false
@export var breaking_progress:float=0
@export var standing_spot:Vector2=Vector2(1044,364)
var dir=1
func _physics_process(_delta: float) -> void:
	if not breaked:
		global_position=standing_spot
		linear_velocity=Vector2(0,0)
		if breaking_progress>=1:
			$bo.play()
			breaked=true
			flag_up.emit() #旗子被拔发出信号，by WX
	else:
		if is_instance_valid($"../start_cutscenes"):
			$"../start_cutscenes".get_node("cutscenes").display(1)
				
	if is_being_breaked==true:
		position.x=randf_range(standing_spot.x-2,standing_spot.x+2)
		position.y=randf_range(standing_spot.y-2,standing_spot.y+2)
		if not $geelgeel.playing:
			$geelgeel.play()
	else:
		$geelgeel.stop()
		if is_instance_valid($"../start_cutscenes") and not breaked:
			$"../start_cutscenes".get_node("cutscenes").display(0)		
		breaking_progress=0
	dir=-dir
func breaking() -> void:
	breaking_progress+=0.01
	if is_instance_valid($"../start_cutscenes"):
		$"../start_cutscenes".get_node("cutscenes").display(breaking_progress)
	print(breaking_progress)

	
