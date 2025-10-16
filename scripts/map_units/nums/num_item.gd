extends RigidBody2D
@export var self_num : int

@export var snap_distance: float = 2.0
@export var snap_min_distance : float = 2.0
@export var snap_strength: float = 6.25
@export var b_gravity: float = 1.0
var rotation_speed : float = 20
var snap_target: Node2D = null
var is_grabbed: bool = false
var sprite: Sprite2D
var on_ground : int = 0

func _ready():
	sprite = $Sprite2D  # 拿到精灵引用

func _physics_process(delta):
	if snap_target:
		gravity_scale = 0
		return_to_vertical()
		var target_pos = snap_target.global_position
		var dir = target_pos - global_position
		if dir.length() > snap_distance:
			global_position += dir * snap_strength * delta
	else:
		gravity_scale = b_gravity

func return_to_vertical():
	var target_rotation = 0.0
	var rotation_speed = 5.0  
	var tween = create_tween()
	tween.tween_property(self, "rotation", target_rotation, 1.0/rotation_speed)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
