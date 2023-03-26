\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \key re \minor
    \time 2/4
    %\partial 8
%harmonia
    r8 re2:m sol:m do re:m
%/harmonia
}
melodia = \fixed do' {
    \key re \minor
    \time 2/4
    \partial 8
%recitação
    la8
    la la la la
    sol la sib la
    sol4 fa~
    fa r8 sol
    \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    Meu cor- po no re- pou- so_es- tá tran- qui- lo Meu
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