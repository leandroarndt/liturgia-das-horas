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
  r1 r4 r\breve r4 si\breve:7~ si:7~ si4:7~ si4:7 mi\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key mi \minor
    \cadenzaOn
%recitação
    r1 fas4 fas\breve mi4 res\breve res mi4 fas mi\breve \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  e_pro --
    \tweak self-alignment-X #-1 \markup{\bold{cla}
                                        \hspace #-0.5
                                        me entre}
    \tweak self-alignment-X #-1 \markup{os}
    \tweak self-alignment-X #-1 \markup{\bold{mor}
                                        \hspace #-0.5
                                        tos a}
    \tweak self-alignment-X #-1 \markup{\bold{vos}} --
    \tweak self-alignment-X #-1 \markup{sa}
    \tweak self-alignment-X #-1 \markup{ver} --
    \tweak self-alignment-X #-1 \markup{\bold{da}
                                        \hspace #-0.5
                                        de?}
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
