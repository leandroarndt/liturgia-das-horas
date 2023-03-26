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
  r1 r4 do\breve:m~ do:m re
%/harmonia
}
melodia = \fixed do' {
    \key sol \minor
    \cadenzaOn
%recitação
    r1 mib4 mib\breve sol fas \bar "|"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{nem a}
    \tweak self-alignment-X #-1 \markup{\bold{pes}te que ca-}
    \tweak self-alignment-X #-1 \markup{\bold{mi}nha pelo es-}
    \tweak self-alignment-X #-1 \markup{\bold{cu}ro,*}
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      piece = "C"
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
