require "../plotrange"
require "uuid"

module LineBaseModule
  # Base class for all line graphs.  Inherits all properties from the
  # documentation for stying lines in gnuplot 5.2, barring pointinterval
  # and pointnumber which were not well documented
  abstract class LineBase
    # Provides configuration options for linetype.  These are default
    # provided at the moment, but this will be especially useful
    # when support is added to provide custom line types, which can be
    # easily supported using this parameter
    property linetype : Int32 = -1

    # Provides configuration options for a line color.  Currently
    # only RGB colors are supported
    property linecolor : String = ""

    # Configuration option for width of a line.  Currently only
    # integer widths are supported
    property linewidth : Int32 = -1

    # Configuration option for point types.  Currently provided by default
    # But same as with linetype it will be convenient to have this added
    # Once users are able to define custom line styles
    property pointtype : Int32 = -1

    # Configuration option for point size.  Currentl only integer point sizes
    # are supported
    property pointsize : Int32 = -1

    # A seperate property associated with each line, analogous to linecolor or linewidth.
    # It is not necessary to place the current terminal in a special mode
    # just to draw dashed lines.
    property dashtype : String = ""

    # Configuration option to draw a number of points instead of a continuous
    # line.  If this option is chosen, `pointtype` and `pointsize` will become relevant
    property with_points : Bool = false

    # Configuration option to draw a line instead of individual points
    # If this is chosen, all line related options are used
    property with_lines : Bool = false

    # Configuration option to draw a line and points
    # If this is chosen, both line and point options are used
    property with_linespoints : Bool = false

    # Configuration option to draw a line with impulses.
    property with_impulses : Bool = false

    # Allows filled curves
    property with_filledcurves : Bool = false

    # Inititialization only requires a line, all other options are
    # optional and will be ignored in the output if not changed.
    def initialize(
      @linetype = -1,
      @linecolor = "",
      @linewidth = -1,
      @pointtype = -1,
      @pointsize = -1,
      @dashtype = "",
      @with_points = false,
      @with_lines = false,
      @with_linespoints = false,
      @with_impulses = false,
      @with_filledcurves = false,
    )
    end

    # Converts a linetype integer into a valid linetype configuration
    # for a gnuplot line
    def parse_linetype
      if linetype != -1
        return "lt #{linetype}"
      end
      return ""
    end

    # Converts a linecolor string into a valid linecolor for
    # a gnuplot line
    def parse_linecolor
      if !linecolor.empty?
        return "lc rgb '#{linecolor}'"
      end
      return ""
    end

    # Converts a linewidth integer into a valid linewith for a
    # gnuplot line
    def parse_linewidth
      if linewidth != -1
        return "lw #{linewidth}"
      end
      return ""
    end

    # Converts a pointtype integer into a valid pointtype configuration
    # for a gnuplot line.  This is ignored unless with_points is true
    def parse_pointtype
      if pointtype != -1
        return "pt #{pointtype}"
      end
      return ""
    end

    # Converts a pointsize integer into a valid pointsize configuration
    # for a gnuplot line.  This is ignored unless with_points is true
    def parse_pointsize
      if pointsize != -1
        return "ps #{pointsize}"
      end
      return ""
    end

    # Converts a dashtype configuration string into a valid dashtype
    # for a gnuplot line.  This is ignored if with_points is true
    def parse_dashtype
      if !dashtype.empty?
        return "dt '#{dashtype}'"
      end
      return ""
    end

    # Converts a withpoints boolean into a valid points configuration
    # option for a gnuplot line
    def parse_withpoints
      if with_points
        return "with points"
      end
      return ""
    end

    # Converts a withlines boolean into a valid lines Configuration
    # option for a gnuplot line
    def parse_withlines
      if with_lines
        return "with lines"
      end
      return ""
    end

    # Converts a withlinepoints boolean into a valid linepoints configuration
    # This an the options above should be exclusive
    def parse_withlinespoints
      if with_linespoints
        return "with linespoints"
      end
      return ""
    end

    # Converts a with_impulses boolean into a valid configuration.
    def parse_withimpulses
      if with_impulses
        return "with impulses"
      end
      return ""
    end

    def parse_withfilledcurves
      if with_filledcurves
        return "with filledcurves"
      end
      return ""
    end

    # Turns a LineBase into a valid configuration string to be
    # passed to gnuplot to create a graph
    def to_config
      config = [
        parse_linetype,
        parse_linecolor,
        parse_linewidth,
        parse_pointtype,
        parse_pointsize,
        parse_dashtype,
        parse_withpoints,
        parse_withlines,
        parse_withlinespoints,
        parse_withimpulses,
        parse_withfilledcurves,
      ].join(" ")
      return config
    end
  end

  class FunctionLine < LineBase
    # The data to plot.  This can be a complex function, a file,
    # a curve, or anything else that gnuplot supports.  These
    # can be combined to produce complex graphs
    property function : String

    def initialize(
      @function,
      **options
    )
      super(**options)
    end

    def to_config
      config = super
      return "#{function} #{config}"
    end
  end

  class ArrayLine(T) < LineBase
    # The data to plot.  This can be an array of
    # numeric data
    property xdata : Array(T)
    property ydata : Array(T) = Array(T).new

    def initialize(
      @xdata : Array(T),
      **options
    )
      super(**options)
    end

    def initialize(
      @xdata : Array(T),
      @ydata : Array(T),
      **options
    )
      super(**options)
    end

    private def join_xy_data
      if ydata.size
        data = xdata.zip(ydata).map do |x, y|
          "#{x}\t#{y}"
        end
        return data.join("\n")
      end
      return xdata.join("\n")
    end

    def to_config
      id = UUID.random.to_s
      fname = "/tmp/#{id}.dat"
      data = join_xy_data
      File.write(fname, data)
      config = "'#{fname}' notitle " + super
      return config
    end
  end
end
