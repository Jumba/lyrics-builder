require 'csv'

class Parser
  def initialize(file)
    @file = file
  end

  def output
    @output ||= process
  end

  def process
    xlsx = Roo::Spreadsheet.open(@file.path)

    data = xlsx.sheet(xlsx.sheets.first).parse    

    slides = []
    groups = {}

    data.each do |row|
      group = Lyric::Group.new(row[0])

      groups[group.name] ||= group

      # Get the true group
      group = groups[group.name]

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

      slides << Lyric::Block.new(group, line[:line_1], line[:line_2], line[:translation])
    end

    slides 
  end  
end
