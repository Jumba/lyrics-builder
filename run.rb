require "nokogiri"
require "pp"
require "securerandom"
require "base64"
require 'pry'
require 'active_support/all'
require 'roo'
require 'caxlsx'

require_relative 'presentation'
require_relative 'parser'
require_relative 'letter_weight'
require_relative 'loader'
require_relative 'export'

filename = ARGV.first

if filename.include?('pro6')
  loader = Loader.new(filename)

  exporter = Export.new(filename, loader)

  exporter.export
else
  parser = Parser.new(filename)

  presentation = Presentation.new(parser.output)

  File.open(filename.sub('xlsx', 'pro6').sub('input', 'output'), 'w') { |file| file.write(presentation.generate) }
end
