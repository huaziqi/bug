extends RigidBody2D
func _ready() -> void:
	$pop.play()
	await get_tree().create_timer(5).timeout
	$pop.play()
	await $pop.finished
	get_parent().bub_num-=1
	queue_free()
func floating(body) -> void:
	for i in range(5):
		if Input.is_action_pressed("left"):
			body.apply_impulse(Vector2(-10,-30))
		if Input.is_action_pressed("right"):
			body.apply_impulse(Vector2(10,-30))
		if is_instance_valid(get_tree()):
			await get_tree().create_timer(0.01).timeout
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		floating(body)
		await get_tree().create_timer(0.05).timeout
		$pop.play()
		await $pop.finished
		get_parent().bub_num-=1
		queue_free()
