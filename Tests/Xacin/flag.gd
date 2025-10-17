extends RigidBody2D
@export var breaked:bool=false
@export var is_being_breaked=false
@export var breaking_progress:float=0
@export var standing_spot:Vector2=Vector2(1044,364)
var dir=1
func _physics_process(_delta: float) -> void:
	if not breaked:
		global_position=standing_spot #如果旗子固定需要改动，后面再改
		if breaking_progress>=1:
			$bo.play()
			breaked=true
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

	
