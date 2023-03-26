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
  r8 do2 fa do1
%/harmonia
}
melodia = \fixed do' {
    \key do \major
    \time 2/2
    \partial 8
%recitação
  sol8
  sol sol sol sol la la la la
  sol4 mi4~ mi4. sol8
%/recitação
}
letra = \lyricmode {
    \teeny
    A- go- ra que_o cla- rão da luz se_a- pa- ga,
    a
    %\tweak self-alignment-X #-1 \markup{\bold{dei}-me por pie-}
    %\tweak self-alignment-X #-1 \markup{\bold{da}de e escu-}
    %\tweak self-alignment-X #-1 \markup{\bold{tai} minha ora-}
    %\tweak self-alignment-X #-1 \markup{\bold{ção!}}
}

\book {
  \paper {
      indent = 0\mm
      scoreTitleMarkup = \markup {
          %\with-color #red
          \fromproperty #'header:piece
      }
  }
  \header {
    %piece = "Ant. 1"
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
