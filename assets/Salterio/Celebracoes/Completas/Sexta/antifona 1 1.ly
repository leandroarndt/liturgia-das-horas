\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \key mi \minor
    \time 3/4
    \partial 4
%harmonia
  r4 mi2.:m do si:7 mi:m mi:m
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \time 3/4
    \partial 4
%recitação
    mi4
    mi mi mi
    sol sol sol
    la la la
    si2.~
    si4 r mi
    \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    De di -- a~e de noi -- te eu cla -- mo a vós.
    De
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