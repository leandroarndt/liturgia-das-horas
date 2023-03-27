\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    %\partial 4
%harmonia
  do4 la:m re2:m~ re:m~ re4:m
%/harmonia
}
melodia = \fixed do' {
    \key re \minor
    \time 2/4
    %\partial 4
    \set melismaBusyProperties = #'()
%recitação
    sol4 sol8 sol
    la4 la8 sol
    fa4( mi
    re)
    \bar "|."
%/recitação
}
letra = \lyricmode {
    \teeny
    lui -- \markup{a_a} -- le -- lui -- \markup{a_a} -- le -- lui -  a
    %\tweak self-alignment-X #1  \markup{aten-}
    %\tweak self-alignment-X #-1 \markup{\bold{dei}-me por pie-}
    %\tweak self-alignment-X #-1 \markup{\bold{da}de e escu-}
    %\tweak self-alignment-X #-1 \markup{\bold{tai} minha ora-}
    %\tweak self-alignment-X #-1 \markup{\bold{ção!}}
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
    %piece = "Ant."
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
  }
}
