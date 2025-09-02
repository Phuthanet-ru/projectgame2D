extends Area2D

@export var next_scene : PackedScene
@export var target_spawn : String   # ชื่อ spawn point ใน scene ถัดไป

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		SceneTransition.change_scene(next_scene, target_spawn)
