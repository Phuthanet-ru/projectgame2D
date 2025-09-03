extends Control

func _on_Start_Game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/ห้องนอน.tscn") # เปลี่ยนเป็นพาธฉากแรกของคุณ

func _on_Quit_Game_button_pressed() -> void:
	get_tree().quit()
