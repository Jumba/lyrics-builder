require 'csv'

class Parser
  def initialize(filename)
    @filename = filename
  end

  def output
    @output ||= process
  end

  def process
    xlsx = Roo::Spreadsheet.open(File.join(Dir.pwd, @filename))

    data = xlsx.sheet(xlsx.sheets.first).parse

    data.inject({}) do |hash, row|
      hash[row[0]] ||= []

      translation_1 = row[3].to_s.upcase.strip.presence
      translation_2 = row[4].to_s.upcase.strip.presence

      line = {
        line_1: row[1].to_s.upcase.strip,
        line_2: row[2].to_s.upcase.strip,
        translation: [translation_1, translation_2].compact.join(', '),
      }

      if line[:line_2] == ''
        line[:line_2] = line[:line_1]
        line[:line_1]= ''
      end

      hash[row[0]] << line

      hash
    end
  end

  def to_s
    "Parser for #{@filename}"
  end
end
