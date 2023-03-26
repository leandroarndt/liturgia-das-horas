extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Volume_value_changed(value):
	$TextoVolume.text = String(value)


func _on_TextoVolume_text_entered(new_text):
	$Volume.value = float(new_text)
