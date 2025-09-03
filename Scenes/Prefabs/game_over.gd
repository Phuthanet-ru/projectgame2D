extends CanvasLayer

@export var restart_scene: PackedScene

func _ready() -> void:
	# ปรับ alignment ของข้อความ
	$VBoxContainer/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	


func _on_retry_pressed() -> void:
	if restart_scene:
		get_tree().change_scene_to_packed(restart_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
