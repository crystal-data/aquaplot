require "./base"
require "../common/helpers"
require "../common/exceptions"

module LineModule
  include SeriesBaseModule
  class Line < XorXY
    #
    # INITIALIZATION
    #
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
  end
end
