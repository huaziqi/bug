extends Node2D
@export var bubble:PackedScene
@export var bub_num=0
func spawn():
	var bub=bubble.instantiate()
	add_child(bub)
	bub_num+=1
	bub.global_position.x=randf_range(global_position.x-100,global_position.x+100)
	bub.global_position.y=global_position.y-150
func _physics_process(_delta: float) -> void:
	print(get_parent().get_child_count())
	if bub_num>=1000:
		get_tree().reload_current_scene()
