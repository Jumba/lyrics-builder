require_relative 'load'
require 'sinatra'

set :bind, '0.0.0.0'

post '/' do    
    options = {
        'template': params.dig('template', nil)
    }
        
    parser = Parser.new(params[:file][:tempfile])    

    presentation = Presentation.new(parser.output, options)    

    presentation.generate.to_xml
end