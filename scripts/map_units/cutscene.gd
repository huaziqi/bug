extends AnimatedSprite2D
func _ready() -> void:
	play("flakes")
	visible=false

func display(modu) -> void:
	visible=true
	modulate.a=1*modu

func _physics_process(_delta: float) -> void:
	if visible==true and modulate.a>0 and not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	elif visible==false or modulate.a<=0:
		$AudioStreamPlayer2D.stop()
			
			
