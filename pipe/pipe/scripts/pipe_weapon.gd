extends RigidBody2D
@export var b_gravity: float = 1.6
var on_ground: bool = false
var on_body: int = 0
@export var b_damage: float = 200
@export var damage_fix: float = 0.2
var damage: float = b_damage

func _physics_process(_delta: float) -> void:
	# 更新伤害数值（根据垂直速度动态调整）
	damage = b_damage + (abs(linear_velocity.y) * damage_fix if linear_velocity.y > 10 else 0)
