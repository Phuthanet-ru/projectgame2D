extends Area2D

@export var target_scene: String
@export var target_door: String
@export var door_id: String

func _on_body_entered(body):
	if body.name == "Player":
		GameManager.next_scene = target_scene
		GameManager.spawn_door = target_door
		SceneTransition.fade_to_scene(load(target_scene))
