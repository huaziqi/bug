extends Node
@onready var pressure_plate: Node2D = $pressure_plate
@onready var door: StaticBody2D = $Door

var basic_position : Vector2
var up_speed : float = 3
var down_speed : float = 3
var max_length : float = 210

func _ready() -> void:
	basic_position = door.global_position
	
func _physics_process(delta: float) -> void:
	if(not pressure_plate.in_normal):
		if door.global_position.y > basic_position.y - max_length:
			door.global_position.y -= up_speed
	else:
		if door.global_position.y < basic_position.y:
			door.global_position.y += down_speed
