require "../series/base"
require "../common/helpers"
require "../common/options"

class GlobalPlotOptions < DataSet
  #
  # GETTERS
  #
  property border : String
  property key : String
  property offsets : Offset
  property scale : XY
  property terminal : String
  property tics : String
  property ticslevel : String
  property time : Bool
  property title : String
  property xlabel : String
  property ylabel : String
  property xrange : XY
  property yrange : XY

  #
  # INITIALIZATION
  #
  def initialize(
    @border = "",
    @key = "",
    @offsets = Offset.new,
    @scale = XY.new,
    @terminal = "qt",
    @tics = "",
    @ticslevel = "",
    @time = false,
    @title = "",
    @xlabel = "",
    @ylabel = "",
    @xrange = XY.new,
    @yrange = XY.new
  )
    super()
    @offsets.set_key("offsets")
    @scale.set_key("size")
  end

  #
  # GETTERS
  #
  def get_border
    _setting_to_string "border", @border
  end

  def get_key
    _setting_to_string "key", @key
  end

  def get_offsets
    @offsets.to_s
  end

  def get_terminal
    _setting_to_string "terminal", @terminal
  end

  def get_tics
    _setting_to_string "tics", @tics
  end

  def get_ticslevel
    _setting_to_string "ticslevel", @ticslevel
  end

  def get_time
    _toggle_to_string "time", @time
  end

  def get_title
    _setting_to_string "title", @title, quotes: true
  end

  def get_xlabel
    _setting_to_string "xlabel", @xlabel, quotes: true
  end

  def get_ylabel
    _setting_to_string "ylabel", @ylabel, quotes: true
  end

  def get_xrange
    @xrange.to_range
  end

  def get_yrange
    @yrange.to_range
  end

  #
  # SETTERS
  #
  def set_border(@border)
  end

  def set_key(@key)
  end

  def set_offsets(left = 0, right = 0, top = 0, bottom = 0)
    @offsets = Offset.new left, right, top, bottom, key: "offsets"
  end

  def set_terminal(@terminal)
  end

  def set_tics(@tics)
  end

  def set_ticslevel(@ticslevel)
  end

  def set_time(@time)
  end

  def set_title(@title)
  end

  def set_xlabel(@xlabel)
  end

  def set_ylabel(@ylabel)
  end

  def set_xrange(x, y)
    @xrange = XY.new x, y, key: "xrange"
  end

  def set_yrange(x, y)
    @yrange = XY.new x, y, key: "yrange"
  end

  def to_s
    [
      get_border,
      get_key,
      get_offsets,
      get_terminal,
      get_tics,
      get_ticslevel,
      get_time,
      get_title,
      get_xlabel,
      get_ylabel,
      get_xrange,
      get_yrange,
    ].reject do |el|
      "#{el}".empty?
    end.join("\n")
  end
end
