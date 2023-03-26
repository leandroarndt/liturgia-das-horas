\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 do\breve si:7 mi:m
%/harmonia
}
melodia = \fixed do' {
    \key sol \major
    \cadenzaOn
%recitação
    r1 mi4 sol\breve fas mi \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{Demos}
    \tweak self-alignment-X #-1 \markup{\bold{gló}ria_a Deus}
    \tweak self-alignment-X #-1 \markup{\bold{Pai} onipo-}
    \tweak self-alignment-X #-1 \markup{\bold{ten}te!}
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
