extends LevelManager
@export var finished:bool=false
@export var pop:PackedScene
@export var error:PackedScene
func _ready() -> void:
	$Steel_Pipe.freezing=true
	$flake_fountain.visible=false
	$hole_background.visible=false
	$flake_fountain/AnimationPlayer.play("new_animation")
	$camera_for_end/AnimationPlayer.play("far")
	await $camera_for_end/AnimationPlayer.animation_finished
	await get_tree().create_timer(1.0).timeout
	$earthquake.play()
	$camera_for_end.shake(8,5)
	await get_tree().create_timer(5.0).timeout
	$earthquake.stop()
	$hole_background.visible=true
	$hole_background/AnimationPlayer.play("break")
	$open.play()
	await get_tree().create_timer(3.0).timeout
	$earthquake.play()
	$camera_for_end.shake(8,1000000)
	await get_tree().create_timer(3.0).timeout
	$flake_fountain.visible=true
	$flake_fountain.modulate.a=0
	$flake_fountain/AnimationPlayer.play("apear")
	await $flake_fountain/AnimationPlayer.animation_finished
	$flakes.play()
	$flake_fountain/AnimationPlayer.play("new_animation")
	$Steel_Pipe.freezing=false
func _process(_delta: float) -> void:
	if $Steel_Pipe.global_position.y<-100 and not finished:
		finished=true
		var e=error.instantiate()
		get_parent().add_child(e)
		await get_tree().create_timer(2.0).timeout
		var p=pop.instantiate()
		get_parent().add_child(p)
		await get_tree().create_timer(2.0).timeout
		get_tree().quit()
		
		
