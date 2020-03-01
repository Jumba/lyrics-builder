class Export
  def initialize(filename, loader)
    @loader = loader
    @filename = filename
  end

  def data
    @loader.output
  end

  def export
    reverse = @loader.reversed?

    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Sheet 1") do |sheet|
        sheet.add_row ["BLOCK", "LINE_1", "LINE_2", "TRANSLATION"]
        data.each do |row|
          group = row.first
          content = reverse ? row.last.reverse : row.last

          sheet.add_row [group, content].flatten
        end
      end

      p.serialize(@filename.sub('PP6in', 'PP6out').sub('pro6', 'xlsx'))
    end
  end
end
