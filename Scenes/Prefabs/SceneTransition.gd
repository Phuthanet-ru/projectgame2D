# SceneTransition.gd
extends Node

func load_scene(next_scene: PackedScene, spawn_point_name: String = "SpawnPoint") -> void:
	if not next_scene:
		push_error("No next_scene assigned!")
		return

	var new_scene = next_scene.instantiate()

	# ลบฉากเก่า
	if get_tree().current_scene:
		get_tree().current_scene.free()

	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

	# หา SpawnPoint ในฉากใหม่
	var spawn_point = new_scene.get_node_or_null(spawn_point_name)
	if spawn_point:
		var player = get_tree().get_first_node_in_group("Player")
		if player:
			player.global_position = spawn_point.global_position
