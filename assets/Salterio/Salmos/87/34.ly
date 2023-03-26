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
  r1 r4 r\breve do si:7~ si4:7 la\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \cadenzaOn
%recitação
    r1 mi4 mi\breve sol fas mi4 do\breve \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{esgo}--
    \tweak self-alignment-X #-0.8 \markup{\bold{tei}
                                        \hspace #-0.5
                                        -me ao so}--
    \tweak self-alignment-X #-1 \markup{\bold{frer} sob o}
    \tweak self-alignment-X #-1 \markup{\bold{vos}
                                        \hspace #-0.5
                                        so}
    \tweak self-alignment-X #-1 \markup{ter}--
    \tweak self-alignment-X #-1 \markup{\bold{ror}
                                        \hspace #-0.5
                                        .}
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
