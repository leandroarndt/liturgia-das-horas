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
  r1 r4 mi\breve:m do si:7 mi:m
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \cadenzaOn
%recitação
    r1 mi4 mi\breve sol la si \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{— O meu}
    \tweak self-alignment-X #-1 \markup{\bold{lei}
                                        \hspace #-0.5
                                        to já}
    \tweak self-alignment-X #-1 \markup{\bold{te}
                                        \hspace #-0.5
                                        nho no}
    \tweak self-alignment-X #-1 \markup{\bold{rei}
                                        \hspace #-0.5
                                        no dos}
    \tweak self-alignment-X #-1 \markup{\bold{mor}
                                        \hspace #-0.5
                                        tos,*}
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
