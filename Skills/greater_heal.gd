
class_name GreaterHeal
 
extends Skill

const filePath : String = "res://Skills/greater_heal.tscn"


func _ready() -> void:
	scenePath = filePath
	skillName = "Greater Heal"
	skillBaseHeal = 50
	skillType = SkillType.HEAL
	
