class Loader
  def initialize(filename)
    @filename = filename
    @data = nil
  end

  def output
    @data ||= process
  end

  def reversed?
    output

    long = @data.max_by do |row|
      row.flatten.map(&:length).sum
    end.first

    long[1].length > long.last.length
  end

  def process
    @data = []

    xml = File.open(File.join(Dir.pwd, @filename)) { |f| Nokogiri::XML(f) }

    groups = xml.xpath("RVPresentationDocument/array[1]/RVSlideGrouping")

    groups.each do |group|
      name = group.attributes["name"].value

      elements = []

      slides = group.xpath("array/RVDisplaySlide")

      slides.each do |slide|
        texts = slide.xpath("array/RVTextElement")

        raw_texts = texts.map do |text|
          match = text.xpath("NSString").select { |string| string.attributes.values.first.value == "PlainText" }

          if match
            Base64.decode64(match.first.children.text)
          else
            ""
          end
        end

        prepared = raw_texts.length == 3 ? raw_texts : [raw_texts.first, '', raw_texts.last]

        @data << [name, prepared.map(&:to_s)]
      end
    end

    @data
  end
end
