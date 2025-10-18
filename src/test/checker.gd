extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and "on_ground" in body:
		body.on_ground+=1 
		if get_parent().collision_layer==2 and "really_on_ground" in body: 
			body.really_on_ground=true
func _on_body_exited(body: Node2D) -> void:
	if body is RigidBody2D and "on_ground" in body:
		body.on_ground-=1
		if get_parent().collision_layer==2 and "really_on_ground" in body: 
			body.really_on_ground=false
