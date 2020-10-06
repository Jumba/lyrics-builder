class Presentation
  MAIN_WIDTH_MODIFIER = 35
  TRANS_WIDTH_MODIFIER = 20

  MAIN_HEIGHT = 60
  TRANS_HEIGHT = 45

  MAIN_FONT_SIZE = 48
  TRANS_FONT_SIZE = 29

  LINE_1_TOP = 510
  LINE_2_TOP = 570
  TRANSLATION_TOP = 630

  def initialize(data)
    @data = data
  end

  def generate
    body do |xml|
      @data.each do |group_name, slides|
        group(xml, group_name) do |xml|
          slide(xml) do |xml|
            text(xml, :spacing, '')
          end

          slides.each do |slide|
            slide(xml) do |xml|
              slide.each do |block, text|
                if text != ''
                  text(xml, block, text.to_s)
                end
              end
            end
          end
        end
      end
    end.doc
  end

  private

  def position(block, text)
    main_width = width(text, MAIN_FONT_SIZE) + 30
    trans_width = width(text, TRANS_FONT_SIZE) + 30

    if block == :line_1
      "{#{((1280 - main_width) / 2).ceil} #{LINE_1_TOP} 0 #{main_width} #{MAIN_HEIGHT}}"
    elsif block == :line_2
      "{#{((1280 - main_width) / 2).ceil} #{LINE_2_TOP} 0 #{main_width} #{MAIN_HEIGHT}}"
    elsif block == :translation
      "{#{((1280 - trans_width) / 2).ceil} #{TRANSLATION_TOP} 0 #{trans_width} #{TRANS_HEIGHT}}"
    end
  end

  def width(text, size)
    LetterWeight.width(text.to_s, size).to_f
  end

  def fillColor(block)
    if block == :translation
      "1 1 1 1"
    else
      "0 0 0 1"
    end
  end

  def RTFData(block, text)
    if block == :translation
      ['{\rtf1\prortf1\ansi\ansicpg1252\uc1\htmautsp\deff2{\fonttbl{\f0\fcharset0 Times New Roman;}{\f2\fcharset0 Georgia;}{\f3\fcharset0 Gotham;}}{\colortbl;\red0\green0\blue0;\red255\green255\blue255;}\loch\hich\dbch\pard\slleading0\plain\ltrpar\itap0{\lang1033\fs59\f3\cf1 \cf1\ql{\f3 {\b\ltrch ', text, '}\li0\sa0\sb0\fi0\qc\par}}}'].join
    else
      ['{\rtf1\prortf1\ansi\ansicpg1252\uc1\htmautsp\deff2{\fonttbl{\f0\fcharset0 Times New Roman;}{\f2\fcharset0 Georgia;}{\f3\fcharset0 Gotham;}}{\colortbl;\red0\green0\blue0;\red255\green255\blue255;}\loch\hich\dbch\pard\slleading0\plain\ltrpar\itap0{\lang1033\fs96\outl0\strokewidth-200\strokec1\f3\cf1 \cf1\ql{\f3 {\b\cf2\ltrch ', text, '}\li0\sa0\sb0\fi0\qc\par}}}'].join
    end
  end

  def WinFlowData(block, text)
    if block == :translation
      ['<FlowDocument TextAlignment="Left" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"><Paragraph Margin="0,0,0,0" TextAlignment="Center" FontFamily="Gotham" FontSize="', TRANS_FONT_SIZE, '"><Span FontWeight="Bold" Foreground="#FF000000" xml:lang="en-us"><Run Block.TextAlignment="Center">', text, "</Run></Span></Paragraph></FlowDocument>"].join
    else
      ['<FlowDocument TextAlignment="Left" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"><Paragraph Margin="0,0,0,0" TextAlignment="Center" FontFamily="Gotham" FontSize="', MAIN_FONT_SIZE, '"><Span FontWeight="Bold" Foreground="#FFFFFFFF" xml:lang="en-us"><Run Block.TextAlignment="Center">', text, "</Run></Span></Paragraph></FlowDocument>"].join
    end
  end

  def WinFontData(block)
    if block == :translation
      '<?xml version="1.0" encoding="utf-16"?><RVFont xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.datacontract.org/2004/07/ProPresenter.Common"><Kerning>0</Kerning><LineSpacing>0</LineSpacing><OutlineColor xmlns:d2p1="http://schemas.datacontract.org/2004/07/System.Windows.Media"><d2p1:A>0</d2p1:A><d2p1:B>0</d2p1:B><d2p1:G>0</d2p1:G><d2p1:R>0</d2p1:R><d2p1:ScA>0</d2p1:ScA><d2p1:ScB>0</d2p1:ScB><d2p1:ScG>0</d2p1:ScG><d2p1:ScR>0</d2p1:ScR></OutlineColor><OutlineWidth>0</OutlineWidth><Variants>Normal</Variants></RVFont>'
    else
      '<?xml version="1.0" encoding="utf-16"?><RVFont xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.datacontract.org/2004/07/ProPresenter.Common"><Kerning>0</Kerning><LineSpacing>0</LineSpacing><OutlineColor xmlns:d2p1="http://schemas.datacontract.org/2004/07/System.Windows.Media"><d2p1:A>255</d2p1:A><d2p1:B>0</d2p1:B><d2p1:G>0</d2p1:G><d2p1:R>0</d2p1:R><d2p1:ScA>1</d2p1:ScA><d2p1:ScB>0</d2p1:ScB><d2p1:ScG>0</d2p1:ScG><d2p1:ScR>0</d2p1:ScR></OutlineColor><OutlineWidth>0</OutlineWidth><Variants>Normal</Variants></RVFont>'
    end
  end

  def slide(xml)
    xml.RVDisplaySlide(
      backgroundColor: "0 0 1 1",
      highlightColor: "1 1 1 0",
      drawingBackgroundColor: true,
      enabled: true,
      hotKey: "",
      label: "",
      notes: "",
      UUID: SecureRandom.uuid.upcase,
      chordChartPath: "",
    ) do
      xml.array(rvXMLIvarName: "cues")
      xml.array(rvXMLIvarName: "displayElements") do
        yield xml
      end
    end
  end

  def text(xml, block, text)
    xml.RVTextElement(
      displayName: "Default",
      UUID: SecureRandom.uuid.upcase,
      typeID: 0,
      displayDelay: 0,
      locked: false,
      persistent: 0,
      fromTemplate: false,
      opacity: 1,
      source: "",
      bezelRadius: 0,
      rotation: 0,
      drawingFill: true,
      drawingShadow: false,
      drawingStroke: false,
      fillColor: fillColor(block),
      adjustsHeightToFit: false,
      verticalAlignment: "0",
      revealType: "0",
    ) do
      xml.RVRect3D(rvXMLIvarName: "position") { xml.text(position(block, text)) }
      xml.shadow(rvXMLIvarName: "shadow") { xml.text("0|0 0 0 1|{494974713987076, -494974713987076}") }
      xml.dictionary(rvXMLIvarName: "stroke") do
        xml.NSColor(rvXMLDictionaryKey: "RVShapeElementStrokeColorKey") { xml.text("1 1 1 1") }
        xml.NSNumber(rvXMLDictionaryKey: "RVShapeElementStrokeWidthKey", hint: "double") { xml.text("0") }
      end

      xml.NSString(rvXMLIvarName: "PlainText") do
        xml.text(Base64.strict_encode64(text))
      end

      xml.NSString(rvXMLIvarName: "RTFData") do
        xml.text(Base64.strict_encode64(RTFData(block, text)))
      end

      xml.NSString(rvXMLIvarName: "WinFlowData") do
        xml.text(Base64.strict_encode64(WinFlowData(block, text)))
      end

      xml.NSString(rvXMLIvarName: "WinFontData") do
        xml.text(Base64.strict_encode64(WinFontData(block)))
      end
    end
  end

  def group(xml, group_name)
    xml.RVSlideGrouping(
      name: group_name,
      color: "0 0 1 1",
      uuid: SecureRandom.uuid.upcase,
    ) do
      xml.array(rvXMLIvarName: "slides") do
        yield xml
      end
    end
  end

  def body
    Nokogiri::XML::Builder.new(encoding: "utf-8") do |xml|
      xml.RVPresentationDocument(
        height: 720,
        width: 1280,
        docType: 0,
        versionNumber: 600,
        usedCount: 0,
        background: "0 0 0 1",
        drawingBackgroundColor: true,
        CCLIDisplay: false,
        lastDateUsed: "2019-06-09T10:15:52+00:00",
        selectedArrangementID: "",
        category: "Zondag Nieuwe Stijl",
        resourcesDirectory: "",
        notes: "",
        CCLIAuthor: "",
        CCLIArtistCredits: "",
        CCLISongTitle: "",
        CCLIPublisher: "",
        CCLICopyrightYear: "",
        CCLISongNumber: "",
        chordChartPath: "",
        os: 1,
        buildNumber: 6016,
      ) do
        xml.RVTimeline(
          timeOffset: 0,
          duration: 0,
          selectedMediaTrackIndex: -1,
          loop: false,
          rvXMLIvarName: "timeline",
        ) do
          xml.array(rvXMLIvarName: "timeCues")
          xml.array(rvXMLIvarName: "mediaTracks")
        end
        xml.array(rvXMLIvarName: "groups") do
          yield xml
        end
        xml.array(rvXMLIvarName: "arrangements")
      end
    end
  end
end
