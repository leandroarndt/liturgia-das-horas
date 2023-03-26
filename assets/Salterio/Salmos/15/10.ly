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
    r1 r4 re\breve:m sol:m~ sol4:m~ sol:m~ sol:m do\breve re4:m
%/harmonia
}
melodia = \fixed do' {
    \key re \minor
    \cadenzaOn
%recitação
    r1 la4 la\breve sol la4 sib la sol\breve( fa4) \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{— Ó Se-}
    \tweak self-alignment-X #-1 \markup{\bold{nhor}, sois minha he-}
    \tweak self-alignment-X #-1 \markup{\bold{ran}-}
    \tweak self-alignment-X #1  \markup{ça_e}
    \tweak self-alignment-X #1  \markup{mi-}
    \tweak self-alignment-X #1  \markup{nha}
    \tweak self-alignment-X #-1 \markup{\bold{ta}ça, *}
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