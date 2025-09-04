extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		GameManager.has_key = true
		queue_free() # ลบกุญแจออกจากฉาก
