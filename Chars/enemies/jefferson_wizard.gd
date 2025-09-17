
class_name Jefferson

extends Character

func _ready() -> void:
	charName = "Jefferson"
	charType = Character.HeroType.ENEMY
	charTotalLife = 100
	charCurrentLife = charTotalLife
	
	start()
	
