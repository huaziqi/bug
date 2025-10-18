extends "res://tests/Xacin/flag.gd"

func _physics_process(_delta: float) -> void:
	
	#global_rotation = 0
	
	if not breaked:
		#linear_velocity=Vector2(0,0)
		position=standing_spot
		if breaking_progress>=1:
			$bo.play()
			breaked=true
	else:
		if is_instance_valid($"../start_cutscenes"):
			$"../start_cutscenes".get_node("cutscenes").display(1)
				
	if is_being_breaked==true:
		standing_spot.x+=5*dir
		standing_spot.y+=1*dir
		if not $geelgeel.playing:
			$geelgeel.play()
	else:
		$geelgeel.stop()
		if is_instance_valid($"../start_cutscenes") and not breaked:
			$"../start_cutscenes".get_node("cutscenes").display(0)		
		breaking_progress=0
	dir=-dir
