extends StaticBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@export var plat:PackedScene
func _ready() -> void:
	modulate.a=0.8
	var p=plat.instantiate()
	p.global_position=global_position
	get_parent().add_child(p)
	var tween = create_tween()
	get_tree().create_timer(0.7).timeout.connect(func():
		random_scale_distortion()
		)
	tween.tween_property(sprite_2d, "modulate:a",
	 0.1,
	 0.9).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

	get_tree().create_timer(1).timeout.connect(func():
		p.queue_free()
		disappear()
		)



func random_scale_distortion():

	var target_scale = Vector2(0.2, 0.2)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite_2d, "scale", target_scale, 0.5)


func disappear():
	get_tree().create_timer(0.3).timeout.connect(func():
		
		queue_free()
		)
