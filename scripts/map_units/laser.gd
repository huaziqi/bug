extends RigidBody2D
@export var breaked:bool=false
@export var is_being_breaked=false
@export var breaking_progress:float=0
@export var standing_spot:Vector2=Vector2(445,410)
@export var r:float = 0
func _ready() -> void:
	get_node("AnimationPlayer").play("laser")
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
		position.x=randf_range(standing_spot.x-2,standing_spot.x+2)
		position.y=randf_range(standing_spot.y-2,standing_spot.y+2)
		if not $geelgeel.playing:
			$geelgeel.play()
	else:
		$geelgeel.stop()	
		breaking_progress=0
func breaking() -> void:
	breaking_progress+=0.02


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if is_instance_valid($"../spawner"):
		$"../spawner".spawn()
