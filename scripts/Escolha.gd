extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal escolhido(hora, tempo, semana, dia_da_semana, festa, invitatorio)

var config:ConfigFile

# Called when the node enters the scene tree for the first time.
func _ready():
	config = ConfigFile.new()
	var erro = config.load('user://liturgiadashoras_acompanhamentomusical.ini')
	if erro:
		print('Erro ao carregar última celebração: não foi possível carregar arquivo.')
	$Margem/OrganizadorVertical/Celebrar.connect('pressed', self, 'concluir')
	atualizar_interface()
	call_deferred('ultima_celebracao')

func ultima_celebracao():
	$Margem/OrganizadorVertical/Grade/Hora.selected = config.get_value('celebracao', 'hora', 0)
	#$Margem/OrganizadorVertical/Grade/Hora._on_Hora_selected($Margem/OrganizadorVertical/Grade/Hora.selected)
	#$Margem/OrganizadorVertical/Grade/Hora.restringir_horas($Margem/OrganizadorVertical/Grade/Hora.selected)
	$Margem/OrganizadorVertical/Grade/Tempo.selected = config.get_value('celebracao', 'tempo', 0)
	#$Margem/OrganizadorVertical/Grade/Tempo._on_Tempo_selected($Margem/OrganizadorVertical/Grade/Tempo.selected)
	$Margem/OrganizadorVertical/Grade/Semana.selected = config.get_value('celebracao', 'semana', 0)
	$Margem/OrganizadorVertical/Grade/Dia.selected = config.get_value('celebracao', 'dia', 0)
	$Margem/OrganizadorVertical/Grade/Invitatorio.pressed = config.get_value('celebracao', 'invitatorio', false)
	var mes_festa = config.get_value('celebracao', 'mes_festa', -1)
	var dia_festa = config.get_value('celebracao', 'dia_festa', 0)
	var nome_festa = config.get_value('celebracao', 'nome_festa', '')
	if dia_festa >= 0 and $Margem/OrganizadorVertical/Grade/Festa.get_root() != null:
		var mes = $Margem/OrganizadorVertical/Grade/Festa.get_root().get_children()
		while mes != null:
			var festa = mes.get_children()
			while festa:
				if festa.get_metadata(0).mes == mes_festa \
				and festa.get_metadata(0).dia == dia_festa \
				and festa.get_metadata(0).nome == nome_festa:
					festa.select(0)
					break
				festa.get_next()
			mes = mes.get_next()
#	if tree.get_root() != null:
#	    var child = tree.get_root().get_children()
#	    while child != null:
#	        # put code here
#	        print(child.get_text(0))
#	        child = child.get_next()
	atualizar_interface()

func salvar():
	config.set_value('celebracao', 'hora', $Margem/OrganizadorVertical/Grade/Hora.selected)
	config.set_value('celebracao', 'tempo', $Margem/OrganizadorVertical/Grade/Tempo.selected)
	config.set_value('celebracao', 'semana', $Margem/OrganizadorVertical/Grade/Semana.selected)
	config.set_value('celebracao', 'dia', $Margem/OrganizadorVertical/Grade/Dia.selected)
	config.set_value('celebracao', 'invitatorio', $Margem/OrganizadorVertical/Grade/Invitatorio.pressed)
	var festa = $Margem/OrganizadorVertical/Grade/Festa.get_selected()
	if festa:
		config.set_value('celebracao', 'mes_festa', festa.get_metadata().mes)
		config.set_value('celebracao', 'dia_festa', festa.get_metadata().dia)
		config.set_value('celebracao', 'nome_festa', festa.get_metadata().nome)
	else:
		config.set_value('celebracao', 'mes_festa', -1)
	config.save('user://liturgiadashoras_acompanhamentomusical.ini')

func concluir():
	salvar()
	var festa = $Margem/OrganizadorVertical/Grade/Festa.get_selected()
	if festa != null:
		festa = festa.get_metadata(0)
	emit_signal(
		"escolhido",
		$Margem/OrganizadorVertical/Grade/Hora.get_selected_id(),
		$Margem/OrganizadorVertical/Grade/Tempo.get_selected_id(),
		$Margem/OrganizadorVertical/Grade/Semana.get_selected_id(),
		$Margem/OrganizadorVertical/Grade/Dia.get_selected_id(),
		festa,
		$Margem/OrganizadorVertical/Grade/Invitatorio.pressed
	)

func restringir_horas(_index=null):
	var hora = find_node('Hora')
	var selecionada = hora.get_selected_id()
	if find_node('Dia').get_selected_id() != Globais.DiaDaSemana.DOMINGO \
	and (
		find_node('Festa').get_selected() == null \
		or find_node('Festa').get_selected().get_metadata().tipo < Globais.TipoCelebracao.SOLENIDADE
	):
		if find_node('Dia').get_selected_id() == Globais.DiaDaSemana.SABADO \
		and selecionada == Globais.Hora.COMPLETAS:
			hora.select(Globais.Hora.I_COMPLETAS)
			find_node('Dia').select(Globais.DiaDaSemana.DOMINGO)
			call_deferred('restringir_horas')
		hora.set_item_disabled(Globais.Hora.I_VESPERAS, true)
		hora.set_item_disabled(Globais.Hora.I_COMPLETAS, true)
		if selecionada == Globais.Hora.I_VESPERAS \
		or selecionada == Globais.Hora.I_COMPLETAS:
			hora.select(2)
	else:
		hora.set_item_disabled(Globais.Hora.I_VESPERAS, false)
		hora.set_item_disabled(Globais.Hora.I_COMPLETAS, false)

func atualizar_semanas():
	var tempo = find_node('Tempo').get_selected_id()
	var semana:OptionButton = find_node('Semana')
	var hora = find_node('Hora')
	var semana_atual = semana.get_selected_id()
	semana.clear()
	if tempo == Globais.Tempo.QUARESMA:
		semana.clear()
		semana.add_item('1', 1)
		semana.add_item('2', 2)
		semana.add_item('3', 3)
		semana.add_item('4', 4)
		semana.add_item('5', 5)
		if semana_atual > 0 and semana_atual < 6:
			semana.select(semana.get_item_index(semana_atual))
	elif tempo == Globais.Tempo.COMUM \
	and not (hora.get_selected_id() == Globais.Hora.COMPLETAS \
	or hora.get_selected_id() == Globais.Hora.I_COMPLETAS):
		semana.add_item('1', 1)
		semana.add_item('2', 2)
		semana.add_item('3', 3)
		semana.add_item('4', 4)
		if semana_atual > 0 and semana_atual < 5:
			semana.select(semana.get_item_index(semana_atual))
	elif hora.get_selected_id() == Globais.Hora.COMPLETAS \
	or hora.get_selected_id() == Globais.Hora.I_COMPLETAS:
			semana.clear()
			semana.add_item('(Invariável)', 0)

func atualizar_invitatorio():
	var hora = find_node('Hora')
	if hora.get_selected_id() == Globais.Hora.LEITURAS \
	or hora.get_selected_id() == Globais.Hora.LAUDES:
		find_node('Invitatorio').disabled = false
	else:
		find_node('Invitatorio').disabled = true
		find_node('Invitatorio').pressed = false

func atualizar_interface(var evento=null):
	restringir_horas()
	atualizar_semanas()
	atualizar_invitatorio()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
