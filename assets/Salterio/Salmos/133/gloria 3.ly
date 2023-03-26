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
  r1 r4 sol\breve:m re:m sol:m
%/harmonia
}
melodia = \fixed do' {
    \key fa \major
    \cadenzaOn
%recitação
    r1 sib4 sib\breve la sib \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{e ao Es-}
    \tweak self-alignment-X #-1 \markup{\bold {pí}rito que ha-}
    \tweak self-alignment-X #-1 \markup{\bold{bi}ta em nosso}
    \tweak self-alignment-X #-1 \markup{\bold{pei}to,}
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