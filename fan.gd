extends Node2D
@export var r_speed:float=3
@export var force: float = 500.0
@export var wind:PackedScene
@export var is_wind:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_rotation+=r_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	global_rotation_degrees+=r_speed
	if r_speed<50:
		slow(0.01)
	else: 
		r_speed=50		
	if r_speed>40:
		if not is_wind:
			is_wind=true
			$AudioStreamPlayer2D.play()
			var w=wind.instantiate()
			w.global_position=global_position
			get_parent().add_child(w)
		var x_diff = $"../Steel_Pipe".global_position.x - global_position.x
		$"../Steel_Pipe".apply_central_force(Vector2.RIGHT * force if x_diff > 0 else Vector2.LEFT * force)

func turn():
	r_speed+=1
func slow(slowdown):
	if r_speed-slowdown>0:
		r_speed-=slowdown
	else:
		r_speed=0
