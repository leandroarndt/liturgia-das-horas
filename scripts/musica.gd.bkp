extends Node
signal fim_musica

export (PackedScene) var Trecho

class_name Musica

# Declare member variables here. Examples:
var iniciada:bool = false
var trecho_atual:int = 0
var tocador_recitado:MidiPlayer
var tocador_medido:MidiPlayer
var track:SMF.MIDITrack
var trechos:Array
var eventos_no_trecho:int
var contador_de_eventos:int = 0
var tocando:bool = false
var thread:Thread

# Called when the node enters the scene tree for the first time.
func _ready():
	iniciada = false
	trechos = []
	trecho_atual = 0
#	var interface = get_tree().get_root().find_node('Interface', true, false)
#	interface.connect('parar', self, 'parar')
#	interface.connect('continuar', self, 'continuar')
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func mudar_trecho():
	yield(get_tree(), 'idle_frame')
	print('mudar_trecho')
	tocando = false
	contador_de_eventos = 0
	print('tocando = ', tocando)
	#get_tree().get_root().find_node('Partitura', true, false).remove_child(get_tree().get_root().find_node('Partitura', true, false).get_child(0))
	#get_tree().get_root().find_node('Rolagem', true, false).scroll_vertical += get_tree().get_root().find_node('Partitura', true, false).get_child(trecho_atual).rect_size.y
	#get_tree().get_root().find_node('Rolagem', true, false).scroll(0, get_tree().get_root().find_node('Partitura', true, false).get_child(trecho_atual).rect_size.y)
	trecho_atual += 1
	if trecho_atual < len(trechos):
		get_tree().get_root().find_node('Rolagem', true, false).scroll_to(0, get_tree().get_root().find_node('Partitura', true, false).get_child(trecho_atual).rect_position.y)
		if !(trechos[trecho_atual - 1].tipo == Globais.Tipos.RECITADO \
		and trechos[trecho_atual].tipo == Globais.Tipos.MEDIDO \
		and !Globais.medir_sempre): # Permite pausa antes da antífona ou refrão
			print('Tocar próximo trecho!')
			tocar()
	else:
		emit_signal('fim_musica')
		print('Fim da música')

func preparar(tocador:MidiPlayer):
	tocador_recitado = tocador

func ler(estrofes:Array):
	_ready()
	var continuacao:Entrada = Entrada.new()
	for e in estrofes:
		for verso in e.ler_versos():
			var l = Trecho.instance()
			add_child(l)
			trechos.append(l)
			trechos[-1].tipo = verso.tipo
			continuacao = trechos[-1].ler(verso.melodia, verso.harmonia, continuacao)
			l.connect('fim_trecho', self, 'mudar_trecho')

func tocar():
	#print('Harmonia: %d; melodia: %d' % [Globais.instrumento_harmonia, Globais.instrumento_melodia])
	if trecho_atual >= len(trechos):
		return
	print('Tocar!')
#	var tipo = trechos[trecho_atual].tipo
	var eventos = [
		SMF.MIDIEventChunk.new(0, 0, SMF.MIDIEventProgramChange.new(Globais.instrumento_melodia)),
		SMF.MIDIEventChunk.new(0, 1, SMF.MIDIEventProgramChange.new(Globais.instrumento_harmonia)),
	]
	var proximo = trechos[trecho_atual].eventos_midi()
	if proximo \
	and trechos[trecho_atual].tipo == Globais.Tipos.RECITADO \
	and !Globais.medir_sempre: # Podemos ter uma lista vazia em uma pausa sem nota precedente
		track = SMF.MIDITrack.new(0, eventos+proximo)
		tocador_recitado.smf_data = SMF.SMFData.new(0, 1, Globais.VALOR_BASE, [track])
		tocador_recitado.play()
	elif proximo:
		if tocando:
			print('Já está tocando!')
			return
		track = SMF.MIDITrack.new(0, eventos+proximo)
		tocador_medido = MidiPlayer.new()
		tocador_medido.volume_db = Globais.volume
		tocador_medido.bank = tocador_recitado.bank
		tocador_medido.set_tempo(Globais.tempo_colcheia)
		add_child(tocador_medido)
		tocador_medido.connect('midi_event', self, 'contar_evento')
		tocador_medido.smf_data = SMF.SMFData.new(0, 1, Globais.VALOR_BASE, [track])
		eventos_no_trecho = len(eventos+proximo)
		thread = Thread.new()
		thread.start(tocador_medido, 'play', 0.0)
	else:
		return
	tocando = true
	iniciada = true
	print('Tocando.')
		
func contar_evento(canal, evento):
	contador_de_eventos += 1
	if contador_de_eventos == eventos_no_trecho:
		print('finalizando tocador')
		contador_de_eventos = 0
		tocador_medido.stop()
		tocando = false
		tocador_medido.queue_free()
		thread.wait_to_finish()
		mudar_trecho()

func parar():
	print('parar')
	tocando = false
#	if !tocando or !tocador_medido:
#		return
#	if trechos[trecho_atual].tipo == Globais.Tipos.RECITADO \
#	and !Globais.medir_sempre:
#		tocador_recitado.stop()
#		return
	if tocador_recitado:
		tocador_recitado.stop()
	if tocador_medido and is_instance_valid(tocador_medido):
		tocador_medido.stop()
#	tocando = false
	contador_de_eventos = 0 # Voltará para o início da linha
	#contador_de_eventos = eventos_no_trecho
	#contar_evento(0, null)
	
func continuar():
	print('continuar')
	if !iniciada:
		tocar()
		return
	if trechos[trecho_atual].tipo == Globais.Tipos.RECITADO \
	and !Globais.medir_sempre:
		tocador_recitado.play()
		return
	if tocador_medido:
		tocador_medido.play()
	else:
		tocar()
