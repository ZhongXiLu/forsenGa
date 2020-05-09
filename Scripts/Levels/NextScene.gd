extends Area2D

export(String, FILE, "*.tscn") var next_scene


func _on_NextScene_body_entered(body):
    get_tree().change_scene(next_scene)
