\version "2.20.0"
#(set! paper-alist (cons '("linha" . (cons (* 148 mm) (* 21 mm))) paper-alist))

\paper {
  #(set-paper-size "linha")
  ragged-right = ##f
}

\language "portugues"

%†

estrofea = {
  \chords{
    \cadenzaOn
%harmonia
%  r1 r4 do\breve sol:m~ sol4:m sol:m re\breve:m
%/harmonia
  }
  \fixed do' {
    \key fa \major
    \cadenzaOn
%recitação
    r1 sol4 sol\breve sib la4 sol la\breve \bar "|"
%/recitação
  }
  \addlyrics {
    \teeny
    \tweak self-alignment-X #1  \markup{As na-}
    \tweak self-alignment-X #-1 \markup{\bold{ções} que cri-}
    \tweak self-alignment-X #-1 \markup{\bold{as}-}
    \tweak self-alignment-X #-1  \markup{tes}
    \tweak self-alignment-X #-1  \markup{vi-}
    \tweak self-alignment-X #-1 \markup{\bold{rão}*}
  }
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
    \new Staff <<
      \new Voice = "melody" \estrofea
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
