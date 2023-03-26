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
  r1 r4 r\breve si~ si4 la\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key sol \major
    \cadenzaOn
%recitação
    r1 mi4 sol\breve fas mi4 do\breve \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{Porque sois}
    \tweak self-alignment-X #-1 \markup{\bold{jus}to, defen-}
    \tweak self-alignment-X #-1 \markup{\bold{dei}-me_e li-}
    \tweak self-alignment-X #-1 \markup{ber}
    \tweak self-alignment-X #-1 \markup{\bold{tai}-me,†}
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
