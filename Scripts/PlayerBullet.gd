extends "res://Scripts/Projectile.gd"

var ppPoof = preload("res://Scenes/ObjectScenes/ppPoof.tscn")


func _on_Bullet_body_entered(body):
    var ppPoof_instance = ppPoof.instance()
    ppPoof_instance.position = global_position
    ppPoof_instance.rotation = global_rotation
    if ppPoof_instance.rotation > 1.5 or ppPoof_instance.rotation < -1.5:
        ppPoof_instance.flip_v = true
    get_parent().add_child(ppPoof_instance)
    
    ._on_Bullet_body_entered(body)
