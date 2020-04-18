extends Control

func _on_Start_pressed():
    get_tree().change_scene("res://Scenes/LevelScenes/Level1.tscn")

func _on_Quit_pressed():
    get_tree().quit()
