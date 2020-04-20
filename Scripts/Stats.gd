extends Node

export var max_health = 1
onready var health = max_health setget set_health

signal health_init(health)
signal health_changed(health)
signal no_health

func _ready():
    emit_signal("health_init", health)

func set_health(value):
    var took_damage = (value < health and value >= 0)
    
    health = value
    if health <= 0:
        health = 0
        emit_signal("no_health")
    emit_signal("health_changed", health)
    
    if took_damage:
        get_parent().modulate = Color(2, 2, 2, 2)
        yield(get_tree().create_timer(0.1), "timeout")
        get_parent().modulate = Color(1, 1, 1, 1)
