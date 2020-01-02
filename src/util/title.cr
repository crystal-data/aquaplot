require "./offset"
require "./font"

class AquaPlot::Util::Title
  private property text : String | Nil
  private property offset : AquaPlot::Util::OffsetXY
  private property font : AquaPlot::Util::Font
  private property textcolor : String | Nil
  private property linetype : Int32 | Nil
  private property enhanced : Bool

  def initialize(
    @text = nil,
    @offset = AquaPlot::Util::OffsetXY.new,
    @font = AquaPlot::Util::Font.new,
    @textcolor = nil,
    @linetype = nil,
    @enhanced = false
  )
  end

  def set_title_text(@text)
  end

  def get_title_text
    _option_to_string "title", @text, quotes: true
  end

  def set_title_offset(x, y)
    self.offset.update(x, y)
  end

  def get_title_offset
    _option_to_string "offset", @offset.to_s
  end

  def set_title_font(family, size = nil)
    self.font.update(family, size)
  end

  def get_title_font
    _option_to_string "font", @font.to_s, quotes: true
  end

  def set_title_color(@textcolor)
  end

  def get_title_color
    _option_to_string "tc", @textcolor, quotes: true
  end

  def set_title_linetype(@linetype)
  end

  def get_title_linetype
    _option_to_string "lt", @linetype
  end

  def set_title_enhanced(@enhanced)
  end

  def get_title_enhanced
    _toggle_option_to_string "enhanced", @enhanced
  end

  def to_option
    if !"#{get_title_text}".empty?
      [
        get_title_text,
        get_title_offset,
        get_title_font,
        get_title_color,
        get_title_linetype,
        get_title_enhanced,
      ].reject do |opt|
        "#{opt}".empty?
      end.join(" ")
    end
  end

  def to_s
    _setting_to_string "", self.to_option
  end
end
