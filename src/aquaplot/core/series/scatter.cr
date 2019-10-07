require "./base"
require "../common/helpers"
require "../common/exceptions"

module ScatterModule
  include SeriesBaseModule

  class Scatter < XorXY
    #
    # INITIALIZATION
    #
    property style : String = "points"

    #
    # MUTATORS
    #
    def show_lines
      @style = "linespoints"
    end

    def hide_lines
      @style = "points"
    end
  end

  class Scatter3D < XYZ
    #
    # INITIALIZATION
    #
    property style : String = "points"

    #
    # MUTATORS
    #
    def show_lines
      @style = "linespoints"
    end

    def hide_lines
      @style = "points"
    end
  end
end
