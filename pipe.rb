require_relative 'load'
require 'optparse'


file = Tempfile.new(['file', '.xlsx'])

file.write($stdin.read)

file.rewind

parser = Parser.new(file)

presentation = Presentation.new(parser.output)

puts presentation.generate