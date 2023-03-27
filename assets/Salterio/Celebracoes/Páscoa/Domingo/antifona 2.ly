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
  re2 re:7 sol:m~ sol8:m
%/harmonia
}
melodia = \fixed do' {
    \key sol \minor
    \time 2/4
    %\partial 
%recitação
    fas8 fas fas fas
    fas fas mi fas
    sol4 sol~
    sol8
    \bar "|."
%/recitação
}
letra = \lyricmode {
    \teeny
    lui -- a, a -- le -- lui -- a, a -- le -- lui -- a.
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
