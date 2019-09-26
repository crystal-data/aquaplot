module CanvasModule
  # This canvas class determines configuration of terminal, size, and
  # scale for a graph.  This is created using defaults on a Plotter
  # instance, but can be overwritten using the `set_canvas` method
  # in order to customize output.
  abstract class CanvasBase
    # Terminal to display the graph if `Plotter.show` is called.
    # The default value that gnuplot uses is "qt", potentially might
    # be worth allowing this to be read from an environment variable
    # to make developing on a different term easier and not have to
    # explicitly list every time.
    property term : String = "png"

    # The size of the figure. Controls the size of the output file, or
    # "canvas". By default, the plot will fill this canvas.
    property size : NamedTuple(x: Int32, y: Int32) = {x: 640, y: 480}

    # scales the plot itself relative to the size of the canvas.
    # Scale values less than 1 will cause the plot to not fill the
    # entire canvas. Scale values larger than 1 will cause only
    # a portion of the plot to fit on the canvas.
    # Please be aware that setting scale values larger than 1 may
    # cause problems.
    property scale : NamedTuple(x: Int32, y: Int32) = {x: 1, y: 1}
    property font : String = "Arial,12"

    # Empty initialization used only by Plotter to create a default
    # canvas if the user does not specify a different one
    def initialize
    end

    # Initialization only using a size to easily swap the size of the output
    # while leaving the reasonably defaults the same
    def initialize(x : Int32, y : Int32)
      @size = {x: x, y: y}
    end

    # Converts the size property into a valid size configuration for
    # a gnuplot figure
    private def parse_size
      "size #{@size[:x]}, #{@size[:y]}"
    end

    # Converts a graph scale into a valid size configuration for a
    # gnuplot figure
    private def parse_scale
      "set size #{@scale[:x]}, #{@scale[:y]}"
    end

    # Converts the font property into a valid font configuration for a
    # gnuplot figure
    private def parse_font
      "font '#{@font}'"
    end

    # Takes configuration properties and returns an array to be extended
    # and passed to a gnuplot command line argument
    def to_config : Array(String)
      config = Array(String).new
      config.push("set term #{@term} #{parse_size} #{parse_font}")
      config.push("#{parse_scale}")
    end
  end

  # This class inherits from base to add options to a gnuplot that only
  # are relevant for a GUI graph visualization.
  abstract class GuiBase < CanvasBase
    property title : String = "AquaPlot"

    # Converts the title property into a valid title configuration for
    # a gnuplot figure
    private def parse_title
      "title '#{@title}'"
    end

    # Takes configuration properties and returns an array to be extended
    # and passed to a gnuplot command line argument
    def to_config : Array(String)
      config = Array(String).new
      config.push("set term #{@term} #{parse_size} #{parse_font} #{parse_title}")
      config.push("#{parse_scale}")
    end
  end

  # Uses the QT terminal to dislpay gnuplot figures
  class QtCanvas < GuiBase
    property term : String = "qt"
  end

  # Uses the png terminal to display gnuplot figures.  Most useful
  # for saving images to disk
  class PngCanvas < CanvasBase
    property term : String = "png"
  end
end
