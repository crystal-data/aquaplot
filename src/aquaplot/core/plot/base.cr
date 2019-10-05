require "../common/helpers"
require "../common/options"
require "../series/base"

module PlotBaseModule
  include OptionsModule
  include SeriesBaseModule

  class GlobalPlotOptions < DataSet
    #
    # GETTERS
    #
    property border : String
    property grid : Bool
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
      @grid = true,
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

    def get_grid
      _toggle_to_string "grid", @grid
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

    def set_grid(@grid)
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
        get_grid,
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

  class PlotBase(T) < GlobalPlotOptions
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
end
