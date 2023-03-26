extends Control

var canto:int = 0
var antifona:int = -1
var refrao:int = -1

var escolha = preload("res://Scenes/Escolha.tscn").instance()

# Declare member variables here. Examples:
#var playing:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	var data = Data.new()
#	data.da_data({'year': 2020, 'month': 8, 'day': 31})
#	print(data.dia)
#	breakpoint
	$MIDIPlayer.soundfont = "res://assets/instrumentos.sf2"   # it is ok to set once only.
	$MIDIPlayer.tempo = Globais.tempo_colcheia
	$MIDIPlayer.volume_db = Globais.volume
	$Musica.preparar($MIDIPlayer)
	$Interface/OrganizadorVertical/Antifona/RepetirAntifona.connect("toggled", self, '_on_RepetirAntifona_toggled')
	#escolha.connect("escolhido", $Controlador, 'montar_parte')
	call_deferred('abre_escolha')
#	call_deferred('dimensionar')
	
#func dimensionar():
#	if OS.has_feature('mobile'):
#		print('Celular!')
#		if OS.window_size.x < OS.window_size.y:
#			$Interface/OrganizadorVertical.rect_size.x = 360
#		else:
#			$Interface/OrganizadorVertical.rect_size.x = 640

func abre_escolha():
	add_child(escolha)
	var selecao = yield(escolha, "escolhido")
	var celebracao:Celebracao = $Controlador.montar_celebracao(selecao[0], selecao[1], selecao[2], selecao[3], selecao[4], selecao[5])
	preparar_parte($Controlador.proxima_parte())
	remove_child(escolha)

func preparar_parte(parte):
	$Interface/OrganizadorVertical/Topo/OpcoesCanto.clear()
	$Interface/OrganizadorVertical/Antifona/OpcoesAntifona.clear()
	$Interface/OrganizadorVertical/OpcoesRefrao.clear()
	for n in range(len(parte.cantos)):
		$Interface/OrganizadorVertical/Topo/OpcoesCanto.add_item(parte.cantos[n].nome, n)
	$Interface/OrganizadorVertical/Topo/OpcoesCanto.select(canto)
	if len(parte.cantos) == 1:
		$Interface/OrganizadorVertical/Topo/OpcoesCanto.disabled = true
	else:
		$Interface/OrganizadorVertical/Topo/OpcoesCanto.disabled = false
	if len(parte.antifonas) >= 1:
		for n in range(len(parte.antifonas)):
			$Interface/OrganizadorVertical/Antifona/OpcoesAntifona.add_item(parte.antifonas[n].nome, n)
		if antifona == -1:
			antifona = 0
		$Interface/OrganizadorVertical/Antifona/OpcoesAntifona.select(antifona)
		$Interface/OrganizadorVertical/Antifona.visible = true
		if len(parte.antifonas) > 1:
			$Interface/OrganizadorVertical/Antifona/OpcoesAntifona.disabled = false
		else:
			$Interface/OrganizadorVertical/Antifona/OpcoesAntifona.disabled = true
	else:
		$Interface/OrganizadorVertical/Antifona.visible = false
	if len(parte.cantos[canto].refroes) > 1:
		for n in range(len(parte.cantos[canto].refroes)):
			$Interface/OrganizadorVertical/OpcoesRefrao.add_item(parte.cantos[canto].refroes[n].nome, n)
		if refrao == -1:
			refrao = 0
		$Interface/OrganizadorVertical/OpcoesRefrao.select(refrao)
		$Interface/OrganizadorVertical/OpcoesRefrao.visible = true
	else:
		$Interface/OrganizadorVertical/OpcoesRefrao.visible = false
	if antifona >= 0:
		$Musica.ler(parte.cantos[canto].montar(parte.antifonas[antifona], refrao))
		$Interface/OrganizadorVertical/Rolagem/Partitura.mostrar(parte.cantos[canto].montar(parte.antifonas[antifona], refrao))
	else:
		$Musica.ler(parte.cantos[canto].montar(Estrofe.new(), refrao))
		$Interface/OrganizadorVertical/Rolagem/Partitura.mostrar(parte.cantos[canto].montar(Estrofe.new(), refrao))
	$Interface/OrganizadorVertical/Rolagem.scroll_vertical = 0

func avancar():
	if escolha in get_children():
		return
	$Musica.parar()
	$Interface/OrganizadorVertical/HBoxContainer/Parar.text = '>'
	canto = 0
	antifona = -1
	refrao = -1
	preparar_parte($Controlador.proxima_parte())

func voltar():
	if escolha in get_children():
		return
	$Musica.parar()
	canto = 0
	antifona = -1
	refrao = -1
	preparar_parte($Controlador.parte_anterior())

#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		tocar_ou_avancar()

func tocar_ou_avancar():
	$Musica.tocar()
	find_node('Parar', true, false).text = '||'

func _on_OpcoesCanto_item_selected(index):
	canto = index
	antifona = -1
	refrao = -1
	preparar_parte($Controlador.parte_atual())


func _on_OpcoesAntifona_item_selected(index):
	antifona = index
	preparar_parte($Controlador.parte_atual())

func _on_OpcoesRefrao_item_selected(index):
	refrao = index
	preparar_parte($Controlador.parte_atual())


func _on_RepetirAntifona_toggled(button_pressed):
	Globais.repetir_antifona = button_pressed
	Globais.salvar()
	preparar_parte($Controlador.parte_atual())

func _on_BotaoConfiguracoes_pressed():
	$Interface/Configuracoes.visible = !$Interface/Configuracoes.visible


func _on_Rolagem_gui_input(event):
#	if !OS.has_feature('web') \
#	and event is InputEventMouseButton \
#	and event.get_button_index() == BUTTON_LEFT \
#	and event.pressed:
#		tocar_ou_avancar()
#		accept_event()
	pass

func _on_nota_button_down():
	tocar_ou_avancar()

func _on_BotaoSalvarConfiguracoes_configuracoes_alteradas():
	$Musica.parar()
	$Interface/OrganizadorVertical/HBoxContainer/Parar.text = '>'
	preparar_parte($Controlador.parte_atual())
