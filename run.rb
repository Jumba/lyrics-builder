require "nokogiri"
require "pp"
require "securerandom"
require "base64"
require 'pry'
require 'active_support/all'

require_relative 'presentation'
require_relative 'parser'
require_relative 'letter_weight'

parser = Parser.new(ARGV.first)

presentation = Presentation.new(parser.output)

File.open(ARGV.first.sub('csv', 'pro6'), 'w') { |file| file.write(presentation.generate) }

