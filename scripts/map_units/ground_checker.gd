extends Area2D

@export var collisions : Array[CollisionShape2D]

func _on_body_entered(body: Node2D) -> void:

	if(body.is_in_group("moveable_ground") and "on_ground" in body):
		print("enter")
		body.on_ground = true


func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("moveable_ground") and "on_ground" in body):
		print("leave")
		body.on_ground = false

		#await get_tree().create_timer(0.3).timeout
		#var collided : bool = false
		#for collision in collisions:
			#for _collision in body.collisions:
				#if not collision.shape.collide(collision.global_transform, _collision.shape,_collision.global_transform):
					#collided = true
		#if(!collided):
			#body.on_ground = false
