\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \key sol \major
    \time 2/4
    %\partial 8
%harmonia
  mi2:m do si:7 mi:m~ mi4:m
%/harmonia
}
melodia = \fixed do' {
    \key sol \major
    \time 2/4
    %\partial 8
%recitação
    r4 mi8 mi
    sol sol sol sol
    fas fas fas fas
    mi4 mi(
    mi)
    \bar "|."
%/recitação
}
letra = \lyricmode {
    \teeny
    um a- bri- go bem se- gu- ro que me sal- va.
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