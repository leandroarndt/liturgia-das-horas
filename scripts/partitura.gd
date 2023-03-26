extends VBoxContainer
#extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var retangulo = Vector2(655, 111)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func mostrar(estrofes:Array):
	for verso in get_children():
		remove_child(verso)
	for e in estrofes:
		var versos = e.ler_versos()
		for v in range(len(versos)):
#		for verso in e.ler_versos():
			var verso = versos[v]
	#for n in canto.montar():
#			var imagem = Image.new()
#			var textura = ImageTexture.new()
			var retangulo = TextureRect.new()
#			imagem.load(e.resource_path.get_base_dir()+'/'+String(verso.n)+'.png')
#			textura.create_from_image(imagem)
			add_child(retangulo)
			retangulo.texture = e.imagens[v]
			retangulo.expand = true
			retangulo.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	#		retangulo.size_flags_horizontal = retangulo.SIZE_EXPAND
	#		retangulo.set_margin(MARGIN_LEFT, 0)
	#		retangulo.set_margin(MARGIN_TOP, 0)
	#		retangulo.set_margin(MARGIN_RIGHT, 655)
	#		retangulo.set_margin(MARGIN_LEFT, 90)
	#		retangulo.set_size(Vector2(655,90))
			retangulo.rect_min_size = Vector2(655,90)
	_on_Rolagem_resized()
	get_parent().scroll_vertical = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rolagem_resized():
	for verso in get_children():
		verso.rect_min_size = Vector2(
			retangulo.x * ($'..'.rect_size.x - 2) / retangulo.x,
			retangulo.y * ($'..'.rect_size.x - 2) / retangulo.x
		)
