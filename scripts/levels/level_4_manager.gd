extends LevelManager
@onready var zhang: RigidBody2D = $Zhang


func _on_dialogue_ended():
	super._on_dialogue_ended()
	hide_item(zhang)
