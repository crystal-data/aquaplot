require "../common/helpers"
require "../common/options"
require "../series/base"
require "../util/title"

class AquaPlot::GlobalPlotOptions < AquaPlot::DataSet
  #
  # GETTERS
  #
  property border : String
  property boxwidth : String
  property grid : Bool
  property key : String
  property offsets : AquaPlot::Util::Offset
  property output : String
  property samples : Int32
  property scale : AquaPlot::Util::XY
  property terminal : String
  property tics : String
  property ticslevel : String
  property time : Bool
  property title : AquaPlot::Util::Title
  property xlabel : String
  property ylabel : String
  property xrange : AquaPlot::Util::XY
  property yrange : AquaPlot::Util::XY

  #
  # INITIALIZATION
  #
  def initialize(
    @border = "",
    @boxwidth = "0.6 relative",
    @data = "histograms",
    @grid = true,
    @key = "",
    @offsets = AquaPlot::Util::Offset.new,
    @output = "",
    @samples = 500,
    @scale = AquaPlot::Util::XY.new,
    @terminal = "qt",
    @tics = "",
    @ticslevel = "",
    @time = false,
    @title = AquaPlot::Util::Title.new,
    @xlabel = "",
    @xrange = AquaPlot::Util::XY.new,
    @ylabel = "",
    @yrange = AquaPlot::Util::XY.new
  )
    super()
    @offsets.set_key("offsets")
    @scale.set_key("size")
    @yrange.set_key("yrange")
    @xrange.set_key("xrange")
  end

  #
  # GETTERS
  #
  def get_border
    _setting_to_string "border", @border
  end

  def get_boxwidth
    _setting_to_string "boxwidth", @boxwidth
  end

  def get_data
    _setting_to_string "style data", @data
  end

  def get_grid
    _toggle_to_string "grid", @grid
  end

  def get_key
    _setting_to_string "key", @key
  end

  def get_offsets
    @offsets.to_s
  end

  def get_output
    _setting_to_string "output", @output, quotes: true
  end

  def get_samples
    _setting_to_string "samples", @samples
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
    @title.to_s
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

  def set_boxwidth(@boxwidth)
  end

  def set_data(@data)
  end

  def set_grid(@grid)
  end

  def set_key(@key)
  end

  def set_offsets(left = 0, right = 0, top = 0, bottom = 0)
    @offsets = AquaPlot::Util::Offset.new left, right, top, bottom, key: "offsets"
  end

  def set_output(@output)
  end

  def set_samples(@samples)
  end

  def set_terminal(@terminal)
  end

  def set_tics(@tics)
  end

  def set_ticslevel(@ticslevel)
  end

  def set_time(@time)
  end

  delegate set_title_text, set_title_font, set_title_offset, set_title_color, set_title_linetype, set_title_enhanced, to: @title

  def set_xlabel(@xlabel)
  end

  def set_ylabel(@ylabel)
  end

  def set_xrange(x, y)
    @xrange = AquaPlot::Util::XY.new x, y, key: "xrange"
  end

  def set_yrange(x, y)
    @yrange = AquaPlot::Util::XY.new x, y, key: "yrange"
  end

  def to_s
    [
      get_border,
      get_boxwidth,
      get_data,
      get_grid,
      get_key,
      get_offsets,
      get_output,
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

class AquaPlot::PlotBase(T) < AquaPlot::GlobalPlotOptions
  property figures : Array(T)

  def initialize(@figures : Array(T), **options)
    super(**options)
  end

  def initialize(figure : T, **options)
    super(**options)
    @figures = [figure]
  end

  def close
    @figures.each do |fig|
      fig.finalize
    end
  end

  def savefig(fname : String, terminal : String = "png")
    save_term = @terminal
    self.set_terminal(terminal)
    self.set_output(fname)
    self.show
    self.set_output("")
    self.set_terminal(save_term)
  end

  def show
    File.write(@filename, self.to_s)
    gnuplot_dispatch()
    File.delete(@filename)
  end

  private def gnuplot_dispatch
    stdout = IO::Memory.new
    Process.run("gnuplot -p #{@filename}", shell: true, output: stdout)
    if stdout
      puts stdout
    end
  end
end
