require "./base"
require "../common/helpers"
require "../common/exceptions"

module LineModule
  include SeriesBaseModule

  class Line < XorXY
    #
    # MUTATORS
    #
    def show_points
      @style = "linespoints"
    end

    def hide_points
      @style = "lines"
    end
  end

  class Line3D < XYZ
    #
    # MUTATORS
    #
    def show_points
      @style = "linespoints"
    end

    def hide_points
      @style = "lines"
    end
  end
end
