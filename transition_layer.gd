extends CanvasLayer

func fade_to_scene(scene_path: String):
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate", Color(0, 0, 0, 1), 0.5) # Fade Out
	await tween.finished
	get_tree().change_scene_to_file(scene_path)
