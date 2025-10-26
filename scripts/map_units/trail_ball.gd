extends StaticBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var particles: GPUParticles2D = $GPUParticles2D

var in_bomb : bool = false

func _ready() -> void:
	var tween = create_tween()
	get_tree().create_timer(0.7).timeout.connect(func():
		random_scale_distortion()
		)
	tween.tween_property(sprite_2d, "modulate:a",
	 0.1,
	 0.9).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

	get_tree().create_timer(1).timeout.connect(func():
		bomb()
		)



func random_scale_distortion():

	var target_scale = Vector2(0.2, 0.2)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite_2d, "scale", target_scale, 0.5)


func bomb():
	particles.emitting = true
	in_bomb = true
	get_tree().create_timer(0.3).timeout.connect(func():
		
		queue_free()
		)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if in_bomb and body.is_in_group("player"):
		apply_explosion_force(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func apply_explosion_force(body: Node2D):
	var explosion_center = global_position
	var body_position = body.global_position
	var direction = (body_position - explosion_center).normalized()

	var distance = explosion_center.distance_to(body_position)
	var force_strength = 350  # 基础力的大小

	if body is RigidBody2D:
		body.apply_central_impulse(direction * force_strength)
