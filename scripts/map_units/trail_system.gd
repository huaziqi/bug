extends Node2D

@onready var player : RigidBody2D = $"../Steel_Pipe"
const TRAIL_BALL = preload("uid://ye8dhs32f7oj")

var last_position : Vector2

func _ready() -> void:
	if(player):
		last_position = player.global_position
	
func _on_timer_timeout() -> void:
	if(player):
		last_position = player.global_position

func _physics_process(delta: float) -> void:
	trail_update()
	
func trail_update():
	if(player.global_position.distance_to(last_position) >= 15):
		generate_trail()

func generate_trail():
	var ball : StaticBody2D = TRAIL_BALL.instantiate()
	if(last_position):
		ball.global_position = last_position

	ball.rotation = player.rotation
	get_tree().current_scene.add_child(ball)
