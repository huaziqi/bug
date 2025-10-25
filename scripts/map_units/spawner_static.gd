extends Node2D
@export var bubble:PackedScene
@export var bub_num=0
@export var mul:bool=false
func spawn():
	var bub=bubble.instantiate()
	add_child(bub)
	bub_num+=1
	bub.global_position.x=randf_range(global_position.x-100,global_position.x+100)
	bub.global_position.y=global_position.y-150
func _physics_process(_delta: float) -> void:
	print(get_parent().get_child_count())
	if bub_num>=600 and not mul:
		mul=true
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.1).timeout
		get_tree().reload_current_scene()
		
