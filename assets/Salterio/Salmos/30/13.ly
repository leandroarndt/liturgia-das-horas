\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 24 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 r4 si\breve:7~ si:7~ si4:7~ si:7 mi\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key sol \major
    \cadenzaOn
%recitação
    r1 fas4 mi res\breve res mi4 fas4 mi\breve \bar "||"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{por}
    \tweak self-alignment-X #1  \markup{que}
    \tweak self-alignment-X #-1 \markup{\bold{vós} me salva-}
    \tweak self-alignment-X #-1 \markup{\bold{reis}, ó}
    \tweak self-alignment-X #1  \markup{Deus}
    \tweak self-alignment-X #1  \markup{fi-}
    \tweak self-alignment-X #-1 \markup{\bold{el}!}
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
