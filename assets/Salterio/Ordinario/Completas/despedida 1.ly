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
%  r4 r\breve r2
%/harmonia
  }
  \fixed do' {
    \key fas \minor
    \cadenzaOn
%recitação
    mi8[ fas] \bar "|" la\breve la4 sols \bar "'" \break
%/recitação
  }
  \addlyrics {
    \teeny
    \tweak self-alignment-X #1  \markup{O}
    \tweak self-alignment-X #-1 \markup{Se -}
    \tweak self-alignment-X #-1 \markup{nhor todo poderoso nos conceda uma noite tran-}
    \tweak self-alignment-X #-1 \markup{qüi-}
    \tweak self-alignment-X #-1 \markup{la}
  }
}

\book {
  \paper {
      indent = 0\mm
      scoreTitleMarkup = \markup {
          \with-color #red
          \fromproperty #'header:piece
      }
  }
    \header {
      piece = "V."
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
