require "nokogiri"
require "pp"
require "securerandom"
require "base64"
require 'pry'
require 'active_support/all'
require 'roo'
require 'caxlsx'
require 'tempfile'

require_relative 'presentation'
require_relative 'parser'
require_relative 'letter_weight'
require_relative 'loader'
require_relative 'export'
require_relative 'lyric/group'
require_relative 'lyric/block'