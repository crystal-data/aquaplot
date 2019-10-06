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

    def initialize(
      x : Indexable(Number),
      **options
    )
      super(x, **options)
    end

    def initialize(
      x : Indexable(Number),
      y : Indexable(Number),
      **options
    )
      super(x, y, **options)
    end

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
