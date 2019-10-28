require 'csv'

class Parser
  def initialize(filename)
    @filename = filename
  end

  def output
    @output ||= process
  end

  def process
    data = CSV.read(File.join(Dir.pwd, @filename), headers:  true)

    data.inject({}) do |hash, row|
      hash[row['BLOCK']] ||= []

      line = {
        line_1: row['LINE_1'].to_s.upcase.strip,
        line_2: row['LINE_2'].to_s.upcase.strip,
        translation: row['TRANSLATION'].to_s.upcase.strip,
      }

      if line[:line_2] == ''
        line[:line_2] = line[:line_1]
        line[:line_1]= ''
      end

      hash[row['BLOCK']] << line

      hash
    end
  end

  def to_s
    "Parser for #{@filename}"
  end
end
