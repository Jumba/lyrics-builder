module Lyric
    class Group 
        attr_reader :name

        def initialize(name)
            @name = name.upcase            
        end
    end
end