extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and "on_ground" in body:
		body.on_ground+=1

func _on_body_exited(body: Node2D) -> void:
	if body is RigidBody2D and "on_ground" in body:
		body.on_ground-=1
