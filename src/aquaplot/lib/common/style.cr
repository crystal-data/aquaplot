require "../meta/base"
require "../common/option"

abstract class Style < ConfigurationObject
    property style : String
    property linestyle : String | Int32
    property linetype : String | Int32
    property linewidth : Int32 | Float64
    property linecolor : String
    property pointtype : Int32
    property pointsize : Int32
    property fill : String
    property fillcolor : String
    property settings : Array(Option) = Array(Option).new

  def initialize(
    @style, @linestyle, @linetype, @linewidth, @linecolor, @pointtype,
    @pointsize, @fill, @fillcolor, @settings)
  end

  def set_option(key : String, value : String | Int32 | Float64)
    options.push(Option.new key, value)
  end

  def get_settings
    settings.map do |el|
      el.commands.join("\n")
    end
  end

  def set_linestyle(@linestyle)
  end

  def get_linestyle
    ls = linestyle.to_s
    if !ls.empty? & (ls != "-1")
      return "ls #{linestyle}"
    end
    ""
  end

  def set_linetype(@linetype)
  end

  def get_linetype
    lt = linetype.to_s
    if !lt.empty? & (lt != "-1")
      return "lt #{linetype}"
    end
    ""
  end

  def set_linewidth(@linewidth)
  end

  def get_linewidth
    if linewidth > 0
      return "lw #{linewidth}"
    end
    ""
  end

  def set_linecolor(@linecolor)
  end

  def get_linecolor
    if !linecolor.empty?
      return "lc rgb #{linecolor}"
    end
    ""
  end

  def set_pointtype(@pointtype)
  end

  def get_pointtype
    if pointtype > 0
      return "pt #{pointtype}"
    end
    ""
  end

  def set_pointsize(@pointsize)
  end

  def get_pointsize
    if pointsize > 0
      return "ps #{pointsize}"
    end
    ""
  end

  def set_fill(@fill)
  end

  def get_fill
    if !fill.empty?
      return "fs #{fill}"
    end
    ""
  end

  def set_fillcolor(@fillcolor)
  end

  def get_fillcolor
    if !fillcolor.empty?
      return "fc rgb #{fillcolor}"
    end
    ""
  end

  def commands
    cmd = [
      get_linestyle,
      get_linetype,
      get_linewidth,
      get_linecolor,
      get_pointtype,
      get_pointsize,
      get_fill,
      get_fillcolor,
    ].join(" ")
    ["with #{style} #{cmd}"]
  end

end

class LineStyle < Style
  def initialize(
    @style = "linespoints",
    @linestyle = -1,
    @linetype = -1,
    @linewidth = 2,
    @linecolor = "",
    @pointtype = 6,
    @pointsize = 1,
    @fill = "",
    @fillcolor = "",
    @settings = Array(Option).new
    )
    super
  end
end

class BarStyle < Style
  def initialize(
    @style = "boxes",
    @linestyle = -1,
    @linetype = -1,
    @linewidth = -1,
    @linecolor = "",
    @pointtype = -1,
    @pointsize = -1,
    @fill = "solid",
    @fillcolor = "",
    @settings = [Option.new "boxwidth", 0.75]
    )
    super
  end
end
