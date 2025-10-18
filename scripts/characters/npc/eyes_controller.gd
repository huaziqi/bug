extends Node
@onready var marker_2d: Marker2D = $Marker2D
@export var _parent : Node2D
@onready var eye: Sprite2D = $Eye

var radius : float = 3
var player : Node2D

func _ready() -> void:
	await _parent.ready
	if("player" in _parent):
		player = _parent.player

func _physics_process(delta: float) -> void:
	rotate_eyes()
	
func rotate_eyes():
	if player == null:
		return

	var dir = (player.global_position - marker_2d.global_position)
	var angle = dir.angle()  # 弧度制
	var dist = min(dir.length(), radius)
	var offset = dir.normalized() * dist
	
	eye.position = marker_2d.position + offset.rotated(-_parent.rotation)
