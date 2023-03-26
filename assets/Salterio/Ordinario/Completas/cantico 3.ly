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
  r1 r4 re\breve:m sol:m~ sol2:m re\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key re \minor
    \cadenzaOn
%recitação
    r1 la4 la\breve sol fa4 mi re\breve \bar "|" \break
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{Pois meus}
    \tweak self-alignment-X #-1 \markup{\bold {o}lhos, viram}
    \tweak self-alignment-X #-1 \markup{\bold{vos}sa}
    \tweak self-alignment-X #-1 \markup{sal}
    \tweak self-alignment-X #-1 \markup{va}
    \tweak self-alignment-X #-1 \markup{\bold{ção}*}
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
