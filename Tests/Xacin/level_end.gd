extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$flake_fountain.visible=false
	$hole_background.visible=false
	$flake_fountain/AnimationPlayer.play("new_animation")
	$camera_for_end/AnimationPlayer.play("far")
	await $camera_for_end/AnimationPlayer.animation_finished
	await get_tree().create_timer(1.0).timeout
	$earthquake.play()
	$camera_for_end.shaking=true
	await get_tree().create_timer(5.0).timeout
	$earthquake.stop()
	$hole_background.visible=true
	$hole_background/AnimationPlayer.play("break")
	$camera_for_end.shaking=false
	$open.play()
	await get_tree().create_timer(3.0).timeout
	$earthquake.play()
	$camera_for_end.shaking=true
	await get_tree().create_timer(3.0).timeout
	$flake_fountain.visible=true
	$flake_fountain.modulate.a=0
	$flake_fountain/AnimationPlayer.play("apear")
	await $flake_fountain/AnimationPlayer.animation_finished
	$flakes.play()
	$flake_fountain/AnimationPlayer.play("new_animation")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
