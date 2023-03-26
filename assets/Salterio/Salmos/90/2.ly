\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"

%†

harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 r\breve re:m sol:m
%/harmonia
}
melodia = \fixed do' {
    \key sol \minor
    \cadenzaOn
%recitação
    r1 fa4 fa\breve la sol \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{e vive à}
    \tweak self-alignment-X #-1 \markup{\bold {som}bra do Se-}
    \tweak self-alignment-X #-1 \markup{\bold{nhor} onipo-}
    \tweak self-alignment-X #-1 \markup{\bold{ten}te,}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      piece = "B"
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
