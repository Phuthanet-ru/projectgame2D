extends CanvasLayer

@onready var fade_rect = $ColorRect

func _ready():
	fade_rect.color.a = 0.0  # เริ่มเกมโปร่งใส

func fade_to_scene(scene: PackedScene):
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, 0.5)
	tween.finished.connect(func():
		get_tree().change_scene_to_packed(scene)
		var tween2 = create_tween()
		tween2.tween_property(fade_rect, "color:a", 0.0, 0.5)
	)
