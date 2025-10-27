extends LevelManager
func _ready() -> void:
	super._ready()
	$Sprite2D.visible=false


func _on_laser_laser_up() -> void:
	$Sprite2D.visible=true
