
class_name Corruption

extends Skill

const filePath : String = "res://Skills/corrupiton.tscn"


func _ready() -> void:
	scenePath = filePath
	skillName = "Corruption"
	skillDotSeconds = 10
	skillBaseDamage = 2
	skillType = SkillType.DOT
	
