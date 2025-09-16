
class_name SirGura
extends Character

	
func _ready():
	addSkillsChar()
	start(Character.HeroType.HERO, 90, "Sir Gura")


func addSkillsChar() -> void:
	var skill1 = ShadowBolt.new()
	skillList["skill_1"] = skill1
	
