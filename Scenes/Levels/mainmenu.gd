extends Control

@onready var music: AudioStreamPlayer2D = $Music
@onready var menu: AudioStreamPlayer2D = $menu
func _ready() -> void:
	if not music.playing:
		menu.play()

func _on_Start_Game_button_pressed() -> void:
	menu.stop()  # กดเริ่มเกมแล้วหยุดเพลงเมนู
	get_tree().change_scene_to_file("res://Scenes/Levels/ห้องนอน.tscn")
	

func _on_Quit_Game_button_pressed() -> void:
	get_tree().quit()
