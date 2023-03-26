\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    %\partial 8
%harmonia
  r4 fa2. do2.
%/harmonia
}
melodia = \fixed do' {
    \key do \major
    \numericTimeSignature
    \time 4/4
    %\partial 8
%recitação
  sol8 sol la la do' la sol mi
  \time 3/4
  sol4 sol4. mi8
%/recitação
}
letra = \lyricmode {
    \teeny
    bus- ca le- van- tar- se Vir- gem pu- ra
    Nas
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
