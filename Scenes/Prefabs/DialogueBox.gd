# DialogueBox.gd
extends Control

@onready var label = $TextureRect/Label
@onready var animation_player = $AnimationPlayer

# ฟังก์ชันสำหรับแสดงข้อความ
func show_dialogue(text: String):
	label.text = text
	animation_player.play("show") # เล่นแอนิเมชันให้กล่องข้อความปรากฏขึ้น

# ฟังก์ชันสำหรับซ่อนข้อความ
func hide_dialogue():
	animation_player.play("hide") # เล่นแอนิเมชันให้กล่องข้อความหายไป
