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
  dos4:m fas:m
%/harmonia
}
melodia = \fixed do' {
    \key fas \minor
    \cadenzaOn
%recitação
    mi4 fas \bar "|." \break
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #-1 \markup{\bold{R.} A -}
    \tweak self-alignment-X #-1 \markup{mém!}
}

\book {
  \paper {
      indent = 0\mm
      scoreTitleMarkup = \markup {
          \with-color #red
          \fromproperty #'header:piece
      }
  }
    \header {
      piece = "R."
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
        %\hide Stem
      }
    }
  }
}
