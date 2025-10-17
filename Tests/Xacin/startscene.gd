extends AnimatedSprite2D
func _ready() -> void:
	play("flakes")
	visible=true
	start_fade()

func start_fade() -> void:
	while modulate.a>0:
		await get_tree().create_timer(0.02).timeout
		modulate.a-=0.02
	visible=false		
