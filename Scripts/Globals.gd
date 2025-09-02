extends Node

# เก็บตำแหน่ง spawn ของแต่ละฉากตาม door_id
var door_positions: Dictionary = {
	"ห้องนอน": {
		"door_A": Vector2(128, 452),
	},
	"ทางเดิน": {
		"door_A": Vector2(944, 108),
		"door_b": Vector2(720, 106),
	}
}

var next_scene: String = ""
var spawn_door: String = ""
