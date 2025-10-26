extends Node2D
@export var bubble:PackedScene
@export var bub_num=0
@export var mul:bool=false
func spawn():
	for i in range(5):
		var bub=bubble.instantiate()
		bub.gravity_scale=0.2
		add_child(bub)
		bub_num+=1
		bub.global_position.x=randf_range($"../Steel_Pipe".global_position.x+100,$"../Steel_Pipe".global_position.x+200)
		bub.global_position.y=randf_range(395,370)
func _physics_process(_delta: float) -> void:
	if bub_num>=70 and not mul:
		mul=true
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.1).timeout
		get_tree().reload_current_scene()
		
