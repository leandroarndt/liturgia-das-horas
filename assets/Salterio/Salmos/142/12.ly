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
  r1 r4 la\breve~ la re la4
%/harmonia
}
melodia = \fixed do' {
    \key la \major
    \cadenzaOn
%recitação
    r1 la4 la\breve la si la4 \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{Já em}
    \tweak self-alignment-X #-1 \markup{\bold{mim} o a-}
    \tweak self-alignment-X #-1 \markup{\bold{len}to se ex-}
    \tweak self-alignment-X #-1 \markup{\bold{tin}-}
    \tweak self-alignment-X #-1 \markup{gue,*}
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
