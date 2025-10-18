extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("as")
	if(body.is_in_group("moveable_ground") and "on_ground" in body):
		body.on_ground = true


func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("moveable_ground") and "on_ground" in body):
		body.on_ground = false
