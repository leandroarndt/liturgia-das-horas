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
  r1 r4 sol\breve:m~ sol:m fa
%/harmonia
}
melodia = \fixed do' {
    \key sol \minor
    \cadenzaOn
%recitação
    r1 sol4 sol\breve sib la \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{Os teus}
    \tweak self-alignment-X #-1 \markup{\bold {o}lhos have-}
    \tweak self-alignment-X #-1 \markup{\bold{rão} de contem-}
    \tweak self-alignment-X #-1 \markup{\bold{plar}*}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      piece = "A"
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
