extends AnimatedSprite2D
@export var enter:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enter:
		$"../Steel_Pipe".apply_central_force(Vector2(0,-1000))


func _on_area_2d_body_entered(_body: Node2D) -> void:
	enter=true
