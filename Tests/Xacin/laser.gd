extends RigidBody2D
@export var breaked:bool=false
@export var is_being_breaked=false
@export var breaking_progress:float=0
@export var standing_spot:Vector2=Vector2(445,400)
@export var r:float = 0
var dir:int=1
func _physics_process(_delta: float) -> void:
	if not breaked:
		global_position=standing_spot
		global_rotation=0
		linear_velocity=Vector2(0,0)
		if breaking_progress>=1:
			$bo.play()
			breaked=true
	else:
		if Input.is_action_just_pressed("E"):
			r+=90
		global_rotation=deg_to_rad(r)			
	if is_being_breaked==true:
		standing_spot.x+=5*dir
		standing_spot.y+=1*dir
		if not $geelgeel.playing:
			$geelgeel.play()
	else:
		$geelgeel.stop()	
		breaking_progress=0
	dir=-dir
func breaking() -> void:
	breaking_progress+=0.01
	print(breaking_progress)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if is_instance_valid($"../spawner"):
		$"../spawner".spawn()
