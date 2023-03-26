extends Button

signal configuracoes_alteradas

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree(), 'idle_frame')
	get_parent().find_node('Tempo').value = Globais.tempo
	get_parent().find_node('TextoTempo').text = String(Globais.tempo)
	get_parent().find_node('Breve').value = Globais.valor_breve
	get_parent().find_node('TextoBreve').text = String(Globais.valor_breve)
	get_parent().find_node('PausaInicial').value = Globais.valor_pausa_inicial
	get_parent().find_node('TextoPausa').text = String(Globais.valor_pausa_inicial)
	get_parent().find_node('BotaoMedirSempre').pressed = Globais.medir_sempre
	get_parent().find_node('InstrumentoMelodia').selected = get_parent().find_node('InstrumentoMelodia').get_item_index(Globais.instrumento_melodia)
	get_parent().find_node('InstrumentoHarmonia').selected = get_parent().find_node('InstrumentoMelodia').get_item_index(Globais.instrumento_harmonia)
	get_parent().find_node('VelocidadeHarmonia').value = Globais.velocidade_harmonia
	get_parent().find_node('TextoVelocidadeHarmonia').text = String(Globais.velocidade_harmonia)
	get_parent().find_node('Volume').value = Globais.volume
	get_parent().find_node('TextoVolume').text = String(Globais.volume)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BotaoSalvarConfiguracoes_pressed():
	Globais.tempo = int(get_parent().find_node('TextoTempo').text)
	Globais.valor_breve = int(get_parent().find_node('TextoBreve').text)
	Globais.valor_pausa_inicial = float(get_parent().find_node('TextoPausa').text)
	Globais.medir_sempre = get_parent().find_node('BotaoMedirSempre').pressed
	Globais.instrumento_melodia = get_parent().find_node('InstrumentoMelodia').get_selected_id()
	Globais.instrumento_harmonia = get_parent().find_node('InstrumentoHarmonia').get_selected_id()
	Globais.velocidade_harmonia = int(get_parent().find_node('TextoVelocidadeHarmonia').text)
	Globais.volume = int(get_parent().find_node('TextoVolume').text)
	Globais.salvar()
	emit_signal("configuracoes_alteradas")
	$"../..".visible = false
