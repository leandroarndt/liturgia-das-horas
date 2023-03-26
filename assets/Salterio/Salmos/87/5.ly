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
    \tweak self-alignment-X #1  \markup{— Satu} --
    \tweak self-alignment-X #-1 \markup{\bold{ra}
                                        \hspace #-0.5
                                        da de}
    \tweak self-alignment-X #-1 \markup{\bold{ma}
                                        \hspace #-0.5
                                        les se en} --
    \tweak self-alignment-X #-1 \markup{\bold{con}
                                        \hspace #-0.5
                                        tra a mi} --
    \tweak self-alignment-X #-1 \markup{\bold{nh'al}
                                        \hspace #-0.5
                                        ma,*}
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
