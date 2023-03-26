\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 21 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"

estrofea = {
  \chords{
    \cadenzaOn
%harmonia
%  r\breve r4 r2
%/harmonia
  }
  \fixed do' {
    \key fas \minor
    \cadenzaOn
%recitação
    sols\breve mi8[ fas] sols4 fas \bar "||"
%/recitação
  }
  \addlyrics {
    \teeny
    \tweak self-alignment-X #1  \markup{e, no fim da vida, uma}
    \tweak self-alignment-X #-1 \markup{mor -}
    \tweak self-alignment-X #-1 \markup{te}
    \tweak self-alignment-X #-1 \markup{san}
    \tweak self-alignment-X #-1 \markup{ta.}
    \tweak self-alignment-X #-1 \markup{\bold{R.} A -}
    \tweak self-alignment-X #-1 \markup{mém!}
  }
}

\book {
  \paper {
      indent = 0\mm
  }
    \header {
      %piece = "V."
      tagline = ""
    }
  \score {
    \new Staff <<
      \new Voice = "melody" \estrofea
    >>
    \layout {
      %indent = 0\cm
      \context {
        \Staff
        \remove "Time_signature_engraver"
        %\hide Stem
      }
    }
  }
}
