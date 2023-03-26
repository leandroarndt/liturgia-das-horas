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
  r1 r4 mi\breve dos:m si:7 mi
%/harmonia
}
melodia = \fixed do' {
  \key mi \major
    \cadenzaOn
%recitação
    r1 sols4 sols\breve mi fas sols \bar "|" \break
%/recitação
}
letra = \lyricmode {
  \teeny
    \tweak self-alignment-X #1  \markup{Eu tran}
    \tweak self-alignment-X #-1 \markup{\bold{qüi}lo vou dei-}
    \tweak self-alignment-X #-1 \markup{\bold{tar}-me e na}
    \tweak self-alignment-X #-1 \markup{\bold{paz} logo ador-}
    \tweak self-alignment-X #-1 \markup{\bold{me}ço,*}
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
