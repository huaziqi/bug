extends Node2D
@export var bubble:PackedScene
func spawn():
	var bub=bubble.instantiate()
	get_tree().root.add_child(bub)
	bub.global_position.x=randf_range(global_position.x-100,global_position.x+100)
	bub.global_position.y=global_position.y-150
	print("fc")
