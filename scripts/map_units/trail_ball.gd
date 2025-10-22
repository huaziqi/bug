extends StaticBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "modulate:a",
	 0.1,
	 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

	get_tree().create_timer(1).timeout.connect(func():
		bomb()
		)

func _physics_process(delta: float) -> void:
	pass

func bomb():
	get_tree().create_timer(0.3).timeout.connect(func():
		queue_free()
		)
