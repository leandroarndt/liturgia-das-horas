\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \partial 4
%harmonia
  r4 fa2 sol:m do:7 fa~ fa4
%/harmonia
}
melodia = \fixed do' {
    \key fa \major
    \time 2/4
    \partial 4
%recitação
    la8 la \bar "|" la la la la \bar "|" sol sol sol sol \bar "|" mi mi mi mi \bar "|" fa4 fa4~ fa \bar "||"
%/recitação
}
letra = \lyricmode {
    \teeny
    A -- le -- lui -- a, a -- le -- lui -- a. A -- le -- lui -- a, a -- le -- lui -- a.
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
    piece = "Ant. 1"
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
