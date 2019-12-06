require "nokogiri"
require "pp"
require "securerandom"
require "base64"
require 'pry'

require_relative 'presentation'
require_relative 'parser'
require_relative 'letter_weight'

parser = Parser.new(ARGV.first)

presentation = Presentation.new(parser.output)

puts presentation.generate


