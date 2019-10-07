require "./base"
require "../common/helpers"
require "../common/exceptions"

module BarModule
  include SeriesBaseModule

  class Bar < XorXY
    #
    # INITIALIZATION
    #
    property style : String = "boxes"
    property fillstyle : String

    def initialize(
      x : Indexable(Number),
      @fillstyle = "solid 0.25",
      **options
    )
      super(x, **options, linewidth: 1)
    end

    def initialize(
      x : Indexable(Number),
      y : Indexable(Number),
      @fillstyle = "solid 0.25",
      **options
    )
      super(x, y, **options, linewidth: 1)
    end

    #
    # GETTERS
    #
    def get_fillstyle
      _option_to_string "fs", @fillstyle
    end

    #
    # SETTERS
    #
    def set_fillstyle(@fillstyle)
    end

    #
    # SERIALIZER
    #
    def to_s
      [
        super,
        get_fillstyle,
      ].join(" ")
    end
  end

  class Bar3D < XYZ
    #
    # INITIALIZATION
    #
    property style : String = "boxes"
    property fillstyle : String

    def initialize(
      x : Indexable(Number),
      y : Indexable(Number),
      z : Indexable(Number),
      @fillstyle = "solid 0.25",
      **options
    )
      super(x, y, z, **options, linewidth: 1)
    end

    #
    # GETTERS
    #
    def get_fillstyle
      _option_to_string "fs", @fillstyle
    end

    #
    # SETTERS
    #
    def set_fillstyle(@fillstyle)
    end

    #
    # SERIALIZER
    #
    def to_s
      [
        super,
        get_fillstyle,
      ].join(" ")
    end
  end
end
