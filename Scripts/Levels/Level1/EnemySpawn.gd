extends Node

var NaM = preload("res://Scenes/ObjectScenes/Levels/Level1/NaM.tscn")
var spawned_enemies = false


func spawn_enemies():
    pass


func _on_Area2D_body_entered(body):
    if not spawned_enemies:
        spawn_enemies()
    spawned_enemies = true
