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
  re2:m la:m sol2. fa4
%/harmonia
}
melodia = \fixed do' {
    \key do \major
    \numericTimeSignature
    \time 4/4
    %\partial 8
%recitação
  re8 do si, la, do la, mi do
  re4 re4~ re8 sol( la) do'
%/recitação
}
letra = \lyricmode {
    \teeny
    cen- do_o Cri- a- dor da cri- a- tu- ra.
    Tem pie-
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
