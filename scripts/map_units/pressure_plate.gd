extends Node2D
@onready var timer: Timer = $Timer


var basic_position : Vector2
var plate_tween : Tween

var in_normal : bool = true
var in_triggled : bool = false:
	set(_v):
		if(_v == false):
			timer.start()


func _ready() -> void:
	basic_position = global_position
	timer.timeout.connect(rise_plate)


func rise_plate():
	plate_tween = create_tween()
	plate_tween.tween_property(self, "global_position:y", basic_position.y, 1.0)
	plate_tween.finished.connect(func():
		in_normal = true
		)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("pressure")):
		if(plate_tween):
			plate_tween.kill()
		in_triggled = true
		in_normal = false
		global_position = basic_position + Vector2(0, 16)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("pressure")):
		in_triggled = false
