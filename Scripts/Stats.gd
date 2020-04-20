extends Node

export var max_health = 1
onready var health = max_health setget set_health

signal health_init(health)
signal health_changed(health)
signal no_health

func _ready():
    emit_signal("health_init", health)

func set_health(value):
    health = value
    if health <= 0:
        health = 0
        emit_signal("no_health")
    emit_signal("health_changed", health)
