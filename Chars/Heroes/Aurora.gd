
class_name Aurora
extends Character

	
func _ready():
	charName = "Aurora"
	charType = Character.HeroType.HERO
	charTotalLife = 100
	charCurrentLife = 100
	charPlayerNumber = PlayerNumber.PLAYER2
	
	addSkillsChar()
	start()
	

func addSkillsChar() -> void:
	pass
	
