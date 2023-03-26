extends Node
signal fim_trecho

class_name TrechoAntigo

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#var momento_melodia = 0
#var momento_harmonia = 0
#var duracao_melodia = 0
#var duracao_harmonia = 0
#var posicao_melodia = -1
#var posicao_harmonia = -1
var terminado:bool = false
var harmonia:Array
var melodia:Array
#enum Tipos {MEDIDO, RECITADO}
enum {HARMONIA, MELODIA}
var tipo:int = Globais.Tipos.RECITADO
var fila_eventos = []
var momento:int = 0

func ler(melodia:String, harmonia:String, continuar:Entrada) -> Entrada:
	var separar:RegEx = RegEx.new()
	var entradas:Array
	var ligaduras:Array = []
	separar.compile("((\\\\tuplet\\s+3\\/2\\s*{\\s*)?(dob|dos|do|reb|res|re|mib|mis|mi|fab|fas|fa|solb|sols|sol|lab|las|la|sib|sis|si|r)(?<oitava>,,|,|''|')?(\\d|\\\\breve)?(.)?(:(\\S+))?)(~)?")
		
	# **** MELODIA ****
	melodia = melodia.replacen('\\bar', '')
	melodia = melodia.replacen('"||"', '')
	melodia = melodia.replacen('"|."', '')
	melodia = melodia.replacen('\\break', '')
	entradas = separar.search_all(melodia)
	ligaduras = []
	for e in entradas:
		var entrada:Entrada = Entrada.new()
		entrada.processar(e.get_string(), false)
		if entrada.duracao == 0:
			entrada.duracao = self.melodia[-1].duracao
		elif entrada.ponto_simples:
			entrada.duracao *= 1.5
		elif entrada.ponto_duplo:
			entrada.duracao *= 1.75
		if entrada.tercina:
			entrada.duracao = entrada.duracao * 2 /3
		if entrada.ligadura:
			ligaduras.append(entrada)
		self.melodia.append(entrada)
	for ligada in ligaduras:
		ligada.duracao += self.melodia[self.melodia.find(ligada)+1].duracao
		self.melodia.remove(self.melodia.find(ligada)+1)
	
	# **** HARMONIA ****
	entradas = separar.search_all(harmonia)
	ligaduras = []
	for e in entradas:
		var entrada = Entrada.new()
		entrada.processar(e.get_string(), true)
		if entrada.duracao == 0:
			entrada.duracao = self.harmonia[-1].duracao
		if entrada.ponto_simples:
			entrada.duracao *= 1.5
		elif entrada.ponto_duplo:
			entrada.duracao *= 1.75
		if entrada.tercina:
			entrada.duracao *= 2/3
		if entrada.ligadura:
			ligaduras.append(entrada)
		self.harmonia.append(entrada)
	for ligada in ligaduras:
		ligada.duracao += self.harmonia[self.harmonia.find(ligada)+1].duracao
		self.harmonia.remove(self.harmonia.find(ligada)+1)
	
	# **** PAUSA INICIAL ****
	if tipo == Globais.Tipos.RECITADO and !self.melodia[0].notas:
		self.melodia[0].duracao = Globais.pausa_inicial
		self.harmonia[0].duracao = Globais.pausa_inicial
	
	# **** CONTINUAÇÃO DA HARMONIA ****
#	var total_antes:int = 0
#	var total_depois:int = 0
#	if tipo == Globais.Tipos.RECITADO:
#		var conjuntos = [self.melodia, self.harmonia]
#		for n in range(len(conjuntos)):
#			var duracoes:String
#			var total:int = 0
#			if n == 0:
#				duracoes = 'Durações da melodia antes: '
#			else:
#				duracoes = 'Durações da harmonia antes: '
#			for i in range(len(conjuntos[n])):
#				duracoes += str(conjuntos[n][i].duracao / Globais.VALOR_BASE / 2) + ', '
#				total_antes += conjuntos[n][i].duracao / Globais.VALOR_BASE / 2
#			print(duracoes, 'total = ', total)
	if !self.harmonia[0].notas:
		var tamanho_antes = len(self.harmonia)
		var n:int = 0
		while !self.harmonia[n].notas:
			var duracao = self.harmonia[n].duracao
			self.harmonia[n].notas = continuar.notas
			self.harmonia[n].duracao = duracao
			n += 1
			if n == len(self.harmonia):
				break
		if tamanho_antes != len(self.harmonia):
			print (tamanho_antes, ' != ', len(self.harmonia))
				
#	if tipo == Globais.Tipos.RECITADO:
#		var conjuntos = [self.melodia, self.harmonia]
#		for n in range(len(conjuntos)):
#			var duracoes:String
#			var total:int = 0
#			if n == 0:
#				duracoes = 'Durações da melodia depois: '
#			else:
#				duracoes = 'Durações da harmonia depois: '
#			for i in range(len(conjuntos[n])):
#				duracoes += str(conjuntos[n][i].duracao / Globais.VALOR_BASE / 2) + ', '
#				total_depois += conjuntos[n][i].duracao / Globais.VALOR_BASE / 2
#	if total_antes != total_depois:
#		print(total_antes, ' != ', total_depois)
#			print(duracoes, 'total = ', total)
	
	# **** CONCLUSÃO ****
	fila_eventos = listar_eventos()
	return self.harmonia[-1]

func eventos_midi():
#	var eventos = []
	if self.tipo == Globais.Tipos.MEDIDO or Globais.medir_sempre:
		#return self.listar_eventos()
		return fila_eventos
#		while not self.terminado:
#			eventos.append(self.proximo())
#		return eventos
	return self.proximo()

func proximo():
	var eventos:Array = []
	#var momento:int = fila_eventos[0].time
	while true:
		var evento:SMF.MIDIEventChunk = fila_eventos.pop_front() # Lê e remove da fila
		if evento.time == momento or evento.time == momento +  1: # Simultâneos ou imediatos (NoteOff+NoteOn) ou início da música
			evento.time = evento.time - momento # Para zerar a espera pelo evento
			eventos.append(evento)
		else:
			fila_eventos.push_front(evento) # Retorna à fila
			momento = evento.time
			break
		if len(fila_eventos) == 0:
			self.terminado = true
			print('Fim do trecho')
			emit_signal('fim_trecho')
			break
	return eventos

func listar_eventos(): # NÃO MAIS --- Tempo medido
	var eventos = [
#		SMF.MIDIEventChunk.new(0, 0, SMF.MIDIEventProgramChange.new(74)), # 52-Aah 74-Recorder
#		SMF.MIDIEventChunk.new(0, 1, SMF.MIDIEventProgramChange.new(1)), # 1 Bright PianoMIDIEventSystemEvent.new(SMF.MIDISystemEventType.set_tempo, Globais.tempo),
	]
	var conjuntos = [melodia, harmonia]
	var velocidade:int
	for conjunto in range(len(conjuntos)):
		if conjunto == 0:
			velocidade = 127
		else:
			velocidade = Globais.velocidade_harmonia
		var momento = 1
		for entrada in conjuntos[conjunto]:
			for nota in entrada.notas:
				eventos.append(SMF.MIDIEventChunk.new(momento, conjunto, SMF.MIDIEventNoteOn.new(nota, velocidade)))
				eventos.append(SMF.MIDIEventChunk.new(momento+entrada.duracao-1, conjunto, SMF.MIDIEventNoteOff.new(nota)))
			momento += entrada.duracao
	eventos.sort_custom(self, 'event_sort')
	return eventos

func event_sort(a:SMF.MIDIEventChunk, b:SMF.MIDIEventChunk):
	return a.time < b.time
	
