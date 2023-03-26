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
%  r1 r4 do\breve~ do re:m
%/harmonia
  }
  \fixed do' {
    \key fa \major
    \cadenzaOn
%recitação
    r1 sol4 sol\breve sol fa \bar "|"
%/recitação
  }
  \addlyrics {
    \teeny
    \tweak self-alignment-X #1  \markup{Contra}
    \tweak self-alignment-X #-1 \markup{\bold{mim} se le-}
    \tweak self-alignment-X #-1 \markup{\bold{van}tam so-}
    \tweak self-alignment-X #-1 \markup{\bold{ber}bos,†}
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
