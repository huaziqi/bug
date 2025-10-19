extends RigidBody2D
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	get_parent().bub_num-=1
	queue_free()
func floating(body) -> void:
	body.apply_impulse(Vector2(100,-300))
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		floating(body)
