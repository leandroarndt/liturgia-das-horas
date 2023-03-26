extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal parar
signal continuar
#signal anterior
#signal proximo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Voltar_pressed():
	$HBoxContainer/Voltar.release_focus()

func _on_Parar_pressed():
	print($OrganizadorVertical/HBoxContainer/Parar.text, ' pressionado')
	if $OrganizadorVertical/HBoxContainer/Parar.text == '||':
		emit_signal('parar')
		$OrganizadorVertical/HBoxContainer/Parar.text = '>'
	else:
		emit_signal('continuar')
		$OrganizadorVertical/HBoxContainer/Parar.text = '||'
	$OrganizadorVertical/HBoxContainer/Parar.release_focus()

func _on_Avancar_pressed():
	$OrganizadorVertical/HBoxContainer/Parar.release_focus()
