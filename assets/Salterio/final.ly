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
%  r1 r4 do\breve la:m~ la4:m re\breve:m~ mi2
%/harmonia
  }
  \fixed do' {
    \key fa \major
    \cadenzaOn
%recitação
    r1 sol4 sol\breve la sol4 fa\breve( mi4 re) \bar "|."
%/recitação
  }
  \addlyrics {
    \teeny
    \tweak self-alignment-X #1  \markup{escu-}
    \tweak self-alignment-X #-1 \markup{\bold{tai}, pois sou}
    \tweak self-alignment-X #-1 \markup{\bold{po}bre e in-}
    \tweak self-alignment-X #-1  \markup{fe-}
    \tweak self-alignment-X #-1 \markup{\bold{liz}!}
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
