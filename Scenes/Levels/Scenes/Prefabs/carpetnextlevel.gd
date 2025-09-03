# Door.gd
extends Area2D

@export var next_scene : PackedScene

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		SceneTransition.load_scene(next_scene)
