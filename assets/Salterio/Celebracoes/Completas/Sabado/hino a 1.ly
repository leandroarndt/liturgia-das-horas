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
%  r4 mi2 fas:m si:7 mi~ mi4
%/harmonia
  }
  \relative do'' {
    \key mi \major
    \time 2/4
    \partial 4
%recitação
    sols8 sols \bar "|" sols sols sols sols \bar "|" fas fas fas fas \bar "|" res res res res \bar "|" mi2~ mi4 \bar "|."
%/recitação
  }
  \addlyrics {
    \teeny
    Ó Se- nhor, ten- de pie- da- de, e_es- cu- tai mi- nha_o- ra- ção! 
    %\tweak self-alignment-X #1  \markup{aten-}
    %\tweak self-alignment-X #-1 \markup{\bold{dei}-me por pie-}
    %\tweak self-alignment-X #-1 \markup{\bold{da}de e escu-}
    %\tweak self-alignment-X #-1 \markup{\bold{tai} minha ora-}
    %\tweak self-alignment-X #-1 \markup{\bold{ção!}}
  }
}

\book {
    \header {
      piece = "Ant. 1"
      tagline = ""
    }
  \score {
    \new Staff <<
      \new Voice = "melody" \estrofea
    >>
  }
}
