\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"

%†

harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 la\breve:m6~ la:m6 mi:m si
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \cadenzaOn
%recitação
    r1 do4 do\breve la sol fas \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  —_Afas --
    \tweak self-alignment-X #-1 \markup{\bold{tas}
                                        \hspace #-0.5
                                        tes de}
    \tweak self-alignment-X #-0.7 \markup{\bold{mim} meus pa} --
    \tweak self-alignment-X #-1 \markup{\bold{ren}
                                        \hspace #-0.5
                                        tes e a} --
    \tweak self-alignment-X #-1 \markup{\bold{mi}
                                        \hspace #-0.5
                                        gos,*}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      %piece = "A"
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
    \layout {
      %indent = 0\cm
      \context {
        \Staff
        \remove "Time_signature_engraver"
        \hide Stem
      }
    }
  }
}
