extends Node

export var max_health = 1
export var invulnerable_time = 0.5

onready var health = max_health setget set_health
var invulnerable = false

signal health_init(health)
signal health_changed(health)
signal took_damage
signal no_health

func _ready():
    emit_signal("health_init", health)

func set_health(value):
    if value >= 0 and !invulnerable:  # prevents taking damage if already dead
        invulnerable = true
        var took_damage = (value < health)
        
        health = value
        if health == 0:
            emit_signal("no_health")
        emit_signal("health_changed", health)
        
        var has_invulnerable_time = true
        if invulnerable_time - 0.1 <= 0:
            invulnerable = false
            has_invulnerable_time = false
            
        if took_damage:
            emit_signal("took_damage")
            get_parent().modulate = Color(2, 2, 2, 2)
            yield(get_tree().create_timer(0.1, false), "timeout")
            get_parent().modulate = Color(1, 1, 1, 1)
        
            if invulnerable_time - 0.1 > 0:
                yield(get_tree().create_timer(invulnerable_time - 0.1, false), "timeout")
            if has_invulnerable_time:
                invulnerable = false
