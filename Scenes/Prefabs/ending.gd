extends CanvasLayer

@export var restart_scene: PackedScene

func _on_retry_pressed() -> void:
	if restart_scene:
		get_tree().change_scene_to_packed(restart_scene)
		queue_free()
func _on_quit_pressed() -> void:
	get_tree().quit()
