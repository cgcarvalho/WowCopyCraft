
class_name ShadowBolt

extends Skill

const filePath : String = "res://Skills/shadow_bolt.tscn"


func _ready() -> void:
	scenePath = filePath
	skillName = "Shadow Bolt"
	skillBaseDamage = 10
	
