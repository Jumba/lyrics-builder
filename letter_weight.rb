class LetterWeight
  WEIGHTS = {
    'A': 1,
    'B': 1,
    'C': 1,
    'D': 1,
    'E': 1,
    'F': 1,
    'G': 1,
    'H': 1,
    'I': 0.5,
    'J': 0.5,
    'K': 1,
    'L': 1,
    'M': 1.5,
    'N': 1,
    'O': 1,
    'P': 1,
    'Q': 1,
    'R': 1,
    'S': 1,
    'T': 1,
    'U': 1,
    'V': 1,
    'W': 1.5,
    'X': 1,
    'Y': 1,
    'Z': 1,
    '.': 0.5,
    ',': 0.5,
    '!': 0.5,
    '?': 1,
    ' ': 0.5,
    ':': 0.5,
    '\'': 0.5,
    '"': 0.5,
  }

  def self.weight_for(letter)
    uletter = letter.upcase.to_sym

    if self::WEIGHTS[uletter]
      self::WEIGHTS[uletter]
    else
      1
    end
  end

  def self.font_path
    File.join(Dir.pwd, 'ArialMT.otf')
  end

  def self.width(string, size)
    result = `convert xc: -font #{font_path} -pointsize #{size} -debug annotate -annotate 0 "  #{string}  " null: 2>&1`

    if result =~ /width: ([\d\.]+);/
      $1.to_f
    end
  end
end
