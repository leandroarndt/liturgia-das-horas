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
    \tweak self-alignment-X #1  \markup{— A vós}
    \tweak self-alignment-X #-1 \markup{\bold{cla}
                                        \hspace #-0.5
                                        mo, Se} --
    \tweak self-alignment-X #-0.75 \markup{\bold{nhor}
                                        \hspace #-0.5
                                        , sem ces} --
    \tweak self-alignment-X #-1 \markup{\bold{sar}
                                        \hspace #-0.5
                                        , todo o}
    \tweak self-alignment-X #-1 \markup{\bold{di}
                                        \hspace #-0.5
                                        a,*}
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
