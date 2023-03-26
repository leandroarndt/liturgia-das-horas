\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \key re \major
    \time 6/8
    %\partial 8
%harmonia
  re2. si4.:m mi:m re2. mi4.:m la
%/harmonia
}
melodia = \fixed do' {
    \key re \major
    \time 6/8
    %\partial 8
%recitação
    fas4. fas
    fas8 mi re mi re si,
    re4. re
    mi8 fas sol fas re mi
    \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    nho- ra
    A- ve, ra- iz, a- ve, por- ta
    Da luz do mun- do_és au-
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
        \harmonia
      }
      \new Voice = "canto" { \melodia }
      \new Lyrics \lyricsto "canto" \letra
    >>
  }
}