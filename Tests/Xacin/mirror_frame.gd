extends StaticBody2D
@export var breaked:bool=false
@export var is_being_breaked=false
@export var breaking_progress:float=0
@export var standing_spot:Vector2=Vector2(0,-23.244)
func _ready() -> void:
	$AnimationPlayer.play("orign")
func _physics_process(_delta: float) -> void:
	position=standing_spot
	if not breaked:
		if breaking_progress>=1:
			breaked=true	
			$AnimationPlayer.play("break")
			$AudioStreamPlayer2D.play()
			await $AnimationPlayer.animation_finished
			queue_free()
	if is_being_breaked==true:
		position.x=randf_range(standing_spot.x-5,standing_spot.x+5)
		position.y=randf_range(standing_spot.y-5,standing_spot.y+5)
	else:	
		breaking_progress=0
func breaking() -> void:
	breaking_progress+=0.02
	print(breaking_progress)
