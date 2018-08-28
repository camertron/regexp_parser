%%{
  machine re_char_type;

  char_type_char = [dDhHsSwWRX];

  # Char types scanner
  # --------------------------------------------------------------------------
  char_type := |*
    char_type_char {
      case text = text(data, ts, te, 1).first
      when '\d'; emit(:type, :digit,      text, ts - 1, te)
      when '\D'; emit(:type, :nondigit,   text, ts - 1, te)
      when '\h'; emit(:type, :hex,        text, ts - 1, te)
      when '\H'; emit(:type, :nonhex,     text, ts - 1, te)
      when '\s'; emit(:type, :space,      text, ts - 1, te)
      when '\S'; emit(:type, :nonspace,   text, ts - 1, te)
      when '\w'; emit(:type, :word,       text, ts - 1, te)
      when '\W'; emit(:type, :nonword,    text, ts - 1, te)
      when '\R'; emit(:type, :linebreak,  text, ts - 1, te)
      when '\X'; emit(:type, :xgrapheme,  text, ts - 1, te)
      else
        raise ScannerError.new(
          "Unexpected character in type at #{text} (char #{ts})")
      end
      fret;
    };
  *|;
}%%
