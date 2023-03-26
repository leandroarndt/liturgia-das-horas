\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 mi\breve fas:m si:7 mi
%/harmonia
}
melodia = \fixed do' {
  \key mi \major
    \cadenzaOn
%recitação
    r1 sols4 sols\breve fas res mi \bar "||"
%/recitação
}
letra = \lyricmode {
  \teeny
    \tweak self-alignment-X #1  \markup{Sobre}
    \tweak self-alignment-X #-1 \markup{\bold{nós} fazei bri-}
    \tweak self-alignment-X #-1 \markup{\bold{lhar} o esplen-}
    \tweak self-alignment-X #-1 \markup{\bold{dor} de vossa}
    \tweak self-alignment-X #-1 \markup{\bold{fa}ce!}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      %piece = "C"
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
