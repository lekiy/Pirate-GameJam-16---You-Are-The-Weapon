class_name SpellIngredient extends Area2D

@export var ingredient : Ingredient

func _ready() -> void:
	$Sprite2D.texture = ingredient.sprite
	$InteractionArea.interact = Callable(self, "_on_interact")
	SignalBuss.possessed.connect(on_possess)


func _on_interact():
	var player = get_tree().get_first_node_in_group("Player")
	
	if player:
		$Posessable.possess(player)

func on_possess(value):
	$CollisionShape2D.disabled = value
