extends CanvasLayer


func _input(event):
    
    if event.is_action_pressed("pause"):
        var paused = !get_tree().paused
        get_tree().paused = paused
        $Control.visible = paused

func _on_Resume_pressed():
    get_tree().paused = false
    $Control.visible = false

func _on_Quit_pressed():
    get_tree().quit()
