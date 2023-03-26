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
    \tweak self-alignment-X #1  \markup{— Chegue a}
    \tweak self-alignment-X #-1 \markup{\bold{mi}
                                        \hspace #-0.5
                                        nha_ora} --
    \tweak self-alignment-X #-1 \markup{\bold{ção} até a}
    \tweak self-alignment-X #-1 \markup{\bold{vos}
                                        \hspace #-0.5
                                        sa pre} --
    \tweak self-alignment-X #-1 \markup{\bold{sen}
                                        \hspace #-0.5
                                        ça,*}
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
