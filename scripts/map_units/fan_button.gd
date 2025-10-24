extends RigidBody2D
@export var press_body:Node2D=null
@export var pressed:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not pressed:
		if body.is_in_group("fan") or body.is_in_group("player"):
			pressed=true
			$"../fan".turn()
			$button.play("pressed")
			$AudioStreamPlayer2D.play()
			press_body=body
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if pressed and body==press_body:
		if 	body.is_in_group("player"):
				await get_tree().create_timer(0.5).timeout
		pressed=false
		$button.play("default")
		$AudioStreamPlayer2D2.play()
		press_body=null
