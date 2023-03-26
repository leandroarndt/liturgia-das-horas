\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 21 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


estrofea = {
  \chords{
    \partial 4
%harmonia
%  re4 fas2:m si:m7 sol re
%/harmonia
  }
  \fixed do' {
    \key re \major
    \time 2/4
    \partial 4
%recitação
  re8 fas
  la8 la la la
  si la la fas
  \tuplet 3/2 { mi4 re si, }
  re2~
  re4
  \bar "|."
%/recitação
  }
  \addlyrics {
    \teeny
    Co- mo e- ra no prin- cí- pio_a- go- ra_e sem- pre. A- mém.
    %\tweak self-alignment-X #-1 \markup{\bold{dei}-me por pie-}
    %\tweak self-alignment-X #-1 \markup{\bold{da}de e escu-}
    %\tweak self-alignment-X #-1 \markup{\bold{tai} minha ora-}
    %\tweak self-alignment-X #-1 \markup{\bold{ção!}}
  }
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
    \new Staff <<
      \new Voice = "melody" \estrofea
    >>
  }
}
