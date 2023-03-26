\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"

%†

harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 r\breve re\breve:7~ re2:7 sol\breve:m
%/harmonia
}
melodia = \fixed do' {
    \key sol \minor
    \cadenzaOn
%recitação
    r1 fas4 fas\breve fas mi4 fas4 sol\breve \bar "|."
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{e no Al-}
    \tweak self-alignment-X #-1 \markup{\bold {tís}simo encon-}
    \tweak self-alignment-X #-1 \markup{\bold{tras}te o}
    \tweak self-alignment-X #-1 \markup{teu}
    \tweak self-alignment-X #-1 \markup{a-}
    \tweak self-alignment-X #-1 \markup{\bold{bri}go.}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      piece = "D"
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
