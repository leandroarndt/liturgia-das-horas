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
  r1 r4 fa\breve do fa
%/harmonia
}
melodia = \fixed do' {
    \key fa \major
    \cadenzaOn
%recitação
    r1 la4 la\breve sol la \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{Vinde, a-}
    \tweak self-alignment-X #-1 \markup{\bold {go}ra, bend -}
    \tweak self-alignment-X #-1 \markup{\bold{zei} ao Senhor}
    \tweak self-alignment-X #-1 \markup{\bold{Deus},*}
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
