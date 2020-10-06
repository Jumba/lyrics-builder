module Lyric
    class Block 
        attr_reader :group, :line_1, :line_2, :translation

        def initialize(group, line_1, line_2, translation)
            @group = group
            @line_1 = line_1
            @line_2 = line_2
            @translation = translation
        end

        def data 
            {
                line_1: line_1,
                line_2: line_2,
                translation: translation,
            }
        end
    end
end