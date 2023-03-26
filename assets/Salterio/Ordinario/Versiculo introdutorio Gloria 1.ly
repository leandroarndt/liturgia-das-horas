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
  r4 fas2:m si:m7 sol re~ re4
%/harmonia
}
melodia = \fixed do' {
    \key re \major
    \time 2/4
    \partial 4
%recitação
  re8 fas
  la4 la8 la
  si la fas mi
  \tuplet 3/2 { mi4 re si, }
  re4 re~
  re
  \bar ""
%/recitação
}
letra = \lyricmode {
    \teeny
    Gló- ria_ao Pai e ao Fi- lho e_ao Es- pí- ri- to San- to.*
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
    %piece = "V."
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
