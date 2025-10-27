extends  LevelManager

@onready var pl_collision: CollisionShape2D = $NumCaculator/Label/AnsPlatform/CollisionShape2D
@onready var b_area: CollisionShape2D = $NumCaculator/Label/AnsPlatform/Area2D/CollisionShape2D
@onready var label: Label = $NumCaculator/Label

func _ready() -> void:
	super._ready()
