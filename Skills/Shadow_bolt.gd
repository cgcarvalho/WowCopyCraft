
class_name ShadowBolt

extends Skill

const filePath : String = "res://Skills/Shadow_bolt.tscn"


func _ready() -> void:
	scenePath = filePath
	skillName = "Shadow Bolt"
	skillBaseDamage = 10
	skillType = SkillType.DIRECT
	
