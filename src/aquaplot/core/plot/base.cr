require "../title"
require "../plotrange"
require "../canvas"
require "../series/base"

module PlotBaseModule
  # Including these allows for much easier namespace
  # handling inside the module, they should not be included
  # outside of modules anywhere
  include CanvasModule
  include TitleModule
  include PlotRangeModule
  include SeriesBaseModule

  # Helper class to combine the attributes of a gnuplot graph
  # into a valid configuration file to be passed directly to
  # gnuplot.  Also provides helpful class methods to create plots
  # from common gnuplot inputs, such as functions.  Eventually,
  # this should also be the base for Plotter3d
  abstract class PlotBase
    # Initializes a default canvas for the plot. This uses the
    # same default options as gnu plot, including the terminal.
    # This gives the user control over the terminal used for output
    # and allows setting the scale and size of the canvas as well.
    property canvas : CanvasBase = QtCanvas.new

    # Initializes an empty title object for the graph
    # This provides a more explicit setting of a title
    # by using the method `set_title` to set title
    # configuration options
    property title : Title = Title.new ""

    # Initializes an empty range object for the graph
    # This provides a zero length range which should
    # not be plotted, but allows for an instance to be
    # created and modified without throwing an error
    # for a bad `PlotRange` object
    property range : PlotRange = PlotRange.new 0, 0

    # Sets an existing canvas as the canvas for the graph.  Useful if
    # a canvas needs to be used for multiple plots, so that all
    # plots can use uniform options
    def set_canvas(@canvas : CanvasBase)
    end

    # Function to set the title of a graph.  If this is not called, the
    # default empty title of the graph will not be displayed.
    def set_title(label, font = 20, **kwargs)
      @title = Title.new label, font, **kwargs
    end

    def set_title(label, font = 20)
      @title = Title.new label, font
    end

    # Resets the title of a graph to a default empty graph.  This title will
    # not impact the output.
    def reset_title
      @title = Title.new ""
    end

    # Saves a graph to a given file.  This will overwrite a file if it currently
    # exists.
    def save_fig(fname : String)
      config = build_plot(fname)
      gnuplot_dispatch(config)
    end

    # Generic helper function that creates a temporary file in order to
    # pass a configuration file to gnuplot, and then cleans up after itself
    # by deleting the file.  This requires that the script has write access
    # where it is run.
    private def gnuplot_dispatch(config)
      Process.run("gnuplot -p -e \"#{config.join("; ")}\"", shell: true)
    end

    # Shows a plot using the default gnuplot term.  When I (Chris Zimmerman)
    # wrote this, I had some issues with my display manager showing the
    # graph correctly with the default term, so it may be useful to allow
    # some checking to see if a display manager can be found before this
    # is called.  Also this is a pain with WSL, since an xserver is required
    def show
      config = self.build_plot
      self.gnuplot_dispatch(config)
    end

    # Currently a rather messy way of creating a configuration file for
    # gnuplot.  Eventually, each piece should override their to_s methods
    # in order to quickly build this file without a messy parsing solution.
    # Ideally this will be moved out of Plotter soon.
    private def build_plot(fname : String = "")
      config = Array(String).new
      if !fname.empty?
        @canvas = PngCanvas.new
        config.push("set output '#{fname}'")
      end
      config += @canvas.to_config
      config += @title.to_config
      return config
    end
  end

  class LinePlot(T) < PlotBase
    property series : Array(T)

    def initialize(@series)
    end

    def initialize(series : T)
      @series = [series]
    end

    private def build_plot(fname : String = "")
      config = super
      plots = series.map do |el|
        el.to_config
      end
      config.push("plot #{plots.join(", ")}")
      return config
    end
  end
end
