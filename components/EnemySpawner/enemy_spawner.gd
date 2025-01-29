class_name EnemySpawner extends Node2D

@export var enemy_scene = preload("res://enemies/enemy.tscn")
@export var stage := 0

func _ready() -> void:
	$Sprite2D.visible = false
