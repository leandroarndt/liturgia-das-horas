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
    r1 r4 do\breve sol:m~ sol4:m~ sol:m~ sol:m do\breve re4:m
%/harmonia
}
melodia = \fixed do' {
    \key re \minor
    \cadenzaOn
%recitação
    r1 sol4 sol\breve re mi4 fa fa mi\breve( re4) \bar "||"
%/recitação
}
letra = \lyricmode {
    \teeny
    \tweak self-alignment-X #1  \markup{e até meu}
    \tweak self-alignment-X #-1 \markup{\bold{cor}po no re-}
    \tweak self-alignment-X #-1 \markup{\bold{pou}-}
    \tweak self-alignment-X #1  \markup{so_es-}
    \tweak self-alignment-X #1  \markup{tá}
    \tweak self-alignment-X #1  \markup{tran-}
    \tweak self-alignment-X #-1 \markup{\bold{qui}lo;}
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
