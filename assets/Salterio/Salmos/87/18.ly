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
  r1 r4 r\breve r4 si\breve:7~ si:7~ si4:7~ si4:7 mi\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \cadenzaOn
%recitação
    r1 fas4 fas\breve mi4 res\breve res mi4 fas mi\breve \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  para
    \tweak self-alignment-X #-1 \markup{\bold{e}
                                        \hspace #-0.5
                                        les}
    \tweak self-alignment-X #-1 \markup{tor} --
    \tweak self-alignment-X #-1 \markup{\bold{nei}
                                        \hspace #-0.5
                                        -me ob} --
    \tweak self-alignment-X #0.5 \markup{\bold{je}} --
    \tweak self-alignment-X #0 \markup{to}
    \tweak self-alignment-X #0 \markup{de_hor} --
    \tweak self-alignment-X #-2 \markup{\bold{ror}
                                        \hspace #-0.5
                                        .}
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
