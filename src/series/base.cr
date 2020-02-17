require "../common/helpers"
require "../util/title"

abstract class AquaPlot::DataSet
  #
  # PROPERTIES
  #
  property filename : String
  property cleanup : Bool = true
  property title : AquaPlot::Util::Title = AquaPlot::Util::Title.new

  #
  # INITIALIZATION
  #
  def initialize(title = nil)
    @filename = _temporary_file
    @title.set_title_text(title)
  end

  #
  # CLEANUP
  #
  def finalize
    _cleanup_dataset(self)
  end

  #
  # GETTERS
  #
  def get_title
    @title.to_option
  end

  def get_filename
    _option_to_string "", @filename, quotes: true
  end

  #
  # SETTERS
  #
  def set_title(text)
    @title.set_title_text(text)
  end
end

abstract class AquaPlot::SeriesOptions < AquaPlot::DataSet
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
    @linecolor : String = "",
    @linewidth : Int32 = 2,
    @pointtype : Int32 = 7,
    @pointsize : Int32 = 2,
    **options
  )
    super(**options)
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

abstract class AquaPlot::XorXY < AquaPlot::SeriesOptions
  def initialize(x : Indexable(Number), **options)
    super(**options)
    _create_data_file(x, @filename)
  end

  def initialize(x : Indexable(Number), y : Indexable(Number), **options)
    super(**options)
    _create_data_file([x, y].transpose, @filename)
  end
end

abstract class AquaPlot::NColumns < AquaPlot::SeriesOptions
  def initialize(*args, labels : Indexable(Number | String) | Nil = nil, **options)
    super(**options)
    puts args.to_a.transpose
  end
end

abstract class AquaPlot::XYZ < AquaPlot::SeriesOptions

  def initialize(
    x : Indexable(Number),
    y : Indexable(Number),
    z : Indexable(Number),
    **options
  )
    super(**options)
    _create_data_file([x, y, z].transpose, @filename)
  end

  def self.from_points(*points : Tuple(U, V, W)) forall U, V, W
    x = [] of U
    y = [] of V
    z = [] of W
    points.each do |i, j, k|
      x << i
      y << j
      z << k
    end
    new(x, y, z)
  end
end
