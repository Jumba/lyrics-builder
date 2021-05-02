require_relative 'load'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: pipe.rb [options]"

  opts.on("-tTEMPLATE", "--template=TEMPLATE", "Select template: blue | green | kids") do |t|
    options[:template] = t
  end
end.parse!

puts options

file = Tempfile.new(['file', '.xlsx'])

file.write($stdin.read)

file.rewind

parser = Parser.new(file)

presentation = Presentation.new(parser.output, options)

puts presentation.generate