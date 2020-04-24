extends Node2D

signal attack_finished

func _notification(what):
    if what == NOTIFICATION_EXIT_TREE:
        connect("attack_finished", get_node("../../"), "attack_finished")
        emit_signal("attack_finished")
