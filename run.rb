require_relative 'load'

filename = ARGV.first

if filename.include?('pro6')
  loader = Loader.new(filename)

  exporter = Export.new(filename, loader)

  exporter.export
else
  parser = Parser.new(filename)

  presentation = Presentation.new(parser.output)

  File.open(filename.sub('xlsx', 'pro6').sub('csv', 'pro6').sub('input', 'output'), 'w') { |file| file.write(presentation.generate) }
end
