require "./base"
require "../common/helpers"
require "../common/exceptions"

class Line < XorXY
  #
  # GETTERS
  #
  property linecolor : String
  property linewidth : Int32
  property pointtype : Int32
  property pointsize : Int32
  property style : String = "lines"

  #
  # INITIALIZATION
  #
  def initialize(
    x : Indexable(Number),
    @linecolor : String = "",
    @linewidth : Int32 = 3,
    @pointtype : Int32 = 7,
    @pointsize : Int32 = 2,
    **options
  )
    super(x, **options)
  end

  def initialize(
    x : Indexable(Number),
    y : Indexable(Number),
    @linecolor : String = "",
    @linewidth : Int32 = 3,
    @pointtype : Int32 = 8,
    @pointsize : Int32 = 3,
    **options
  )
    super(x, y, **options)
  end

  #
  # GETTERS
  #
  def get_linecolor
    _option_to_string "lc", @linecolor, quotes: true
  end

  def get_linewidth
    _option_to_string "lw", @linewidth
  end

  def get_pointtype
    _option_to_string "pt", @pointtype
  end

  def get_pointsize
    _option_to_string "ps", @pointsize
  end

  def get_style
    _option_to_string "with", @style
  end

  #
  # SETTERS
  #
  def set_linecolor(@linecolor)
  end

  def set_linewidth(@linewidth)
  end

  #
  # MUTATORS
  #
  def show_points
    @style = "linespoints"
  end

  def hide_points
    @style = "lines"
  end

  #
  # SERIALIZER
  #
  def to_s
    [
      get_filename,
      get_style,
      get_linecolor,
      get_linewidth,
      get_pointtype,
      get_pointsize,
      get_title,
    ].join(" ")
  end
end
