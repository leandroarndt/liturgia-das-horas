\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"

%†

harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 r\breve do si:7~ si4:7 la\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \cadenzaOn
%recitação
    r1 mi4 mi\breve sol fas mi4 do\breve \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{e de}
    \tweak self-alignment-X #-1 \markup{\bold{noi}
                                        \hspace #-0.5
                                        te se e} --
    \tweak self-alignment-X #-1 \markup{\bold{le}
                                        \hspace #-0.5
                                        va até}
    \tweak self-alignment-X #-1 \markup{\bold{vós} meu}
    \tweak self-alignment-X #-1 \markup{ge} --
    \tweak self-alignment-X #-1 \markup{\bold{mi}
                                        \hspace #-0.5
                                        do.}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      %piece = "A"
      tagline = ""
    }
  \score {
    <<
      \new ChordNames {
        \set chordChanges = ##t
        \set noChordSymbol = ""
        \harmonia
      }
      \new Voice = "canto" { \melodia }
      \new Lyrics \lyricsto "canto" \letra
    >>
    \layout {
      %indent = 0\cm
      \context {
        \Staff
        \remove "Time_signature_engraver"
        \hide Stem
      }
    }
  }
}
