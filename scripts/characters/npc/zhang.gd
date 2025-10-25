extends Node
@export var level_manager: Node2D
@export var player : Node2D
@onready var interact_icon: Sprite2D = $InteractIcon

var in_area : bool = false
signal interact

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("E") and in_area):
		interact.emit()
		if(level_manager and level_manager.has_method("npc_talking")):
			level_manager.npc_talking()

func _on_interact_area_body_entered(body: Node2D) -> void:
	interact_icon.show()
	in_area = true
	
func _on_interact_area_body_exited(body: Node2D) -> void:
	interact_icon.hide()
	in_area = false
