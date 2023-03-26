\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 25 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"


harmonia = \chordmode {
    \cadenzaOn
%harmonia
  r1 r4 dos\breve:m fas:m si:7 mi
%/harmonia
}
melodia = \fixed do' {
  \key mi \major
    \cadenzaOn
%recitação
    r1 sols4 sols\breve fas la sols \bar "|" \break
%/recitação
}
letra = \lyricmode {
  \teeny
    \tweak self-alignment-X #1  \markup{Vós que sou-}
    \tweak self-alignment-X #-1 \markup{\bold{bes}tes ali-}
    \tweak self-alignment-X #-1 \markup{\bold{viar}-me nos mo-}
    \tweak self-alignment-X #-1 \markup{\bold{men}tos de afli-}
    \tweak self-alignment-X #-1 \markup{\bold{ção*}}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
%      piece = "B"
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
