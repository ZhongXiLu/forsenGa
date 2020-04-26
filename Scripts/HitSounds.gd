extends Node

export (Array, Resource) var sounds = []


func _on_Stats_took_damage():
    $AudioStreamPlayer.stream = sounds[randi() % sounds.size()]
    $AudioStreamPlayer.play()
