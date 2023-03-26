\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \partial 8
%harmonia
  r8 mi2:m re do la:m~ la4:m 
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \time 2/4
    \partial 8
%recitação
  sol8
  sol mi fas sol
  la4 la8 si
  sol mi fas sol
  la4 la~
  la
  \bar ""
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #-1 \markup{\bold{V.} Vós}
    sois o Deus fi- el, que sal- vas- tes vos- so po- vo
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
    piece = "V."
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
