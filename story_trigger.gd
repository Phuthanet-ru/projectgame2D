extends Area2D

@export var dialogue_text: String = "ข้อความบทพูดของคุณ"

func _on_body_entered(body):
	if body.name == "Player":
		var dialogue_box_scene = load("res://Scenes/Prefabs/dialogue_box.tscn")
		var dialogue_box = dialogue_box_scene.instantiate()
		get_tree().current_scene.add_child(dialogue_box)
