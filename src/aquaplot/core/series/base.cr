require "../common/helpers"

module SeriesBaseModule
  abstract class DataSet
    #
    # PROPERTIES
    #
    property filename : String
    property cleanup : Bool = true
    property title : String = ""

    #
    # INITIALIZATION
    #
    def initialize(@title = "")
      @filename = _temporary_file
    end

    #
    # CLEANUP
    #
    def finalize
      _cleanup_dataset(self)
    end

    #
    # GETTERS
    #
    def get_title
      _option_to_string "title", @title, quotes: true
    end

    def get_filename
      _option_to_string "", @filename, quotes: true
    end

    #
    # SETTERS
    #
    def set_title(@title)
    end
  end

  abstract class LineOptions < DataSet
    #
    # GETTERS
    #
    property linecolor : String
    property linewidth : Int32
    property pointtype : Int32
    property pointsize : Int32
    property style : String = "lines"

    #
    # INITIALIZATION
    #
    def initialize(
      @linecolor : String = "",
      @linewidth : Int32 = 3,
      @pointtype : Int32 = 7,
      @pointsize : Int32 = 2,
      **options
    )
      super(**options)
    end

    #
    # GETTERS
    #
    def get_linecolor
      _option_to_string "lc", @linecolor, quotes: true
    end

    def get_linewidth
      _option_to_string "lw", @linewidth
    end

    def get_pointtype
      _option_to_string "pt", @pointtype
    end

    def get_pointsize
      _option_to_string "ps", @pointsize
    end

    def get_style
      _option_to_string "with", @style
    end

    #
    # SETTERS
    #
    def set_linecolor(@linecolor)
    end

    def set_linewidth(@linewidth)
    end

    #
    # MUTATORS
    #
    def show_points
      @style = "linespoints"
    end

    def hide_points
      @style = "lines"
    end

    #
    # SERIALIZER
    #
    def to_s
      [
        get_filename,
        get_style,
        get_linecolor,
        get_linewidth,
        get_pointtype,
        get_pointsize,
        get_title,
      ].join(" ")
    end
  end

  abstract class XorXY < LineOptions
    def initialize(x : Indexable(Number), **options)
      super(**options)
      _create_data_file(x, @filename)
    end

    def initialize(x : Indexable(Number), y : Indexable(Number), **options)
      super(**options)
      _create_data_file([x, y].transpose, @filename)
    end
  end
end
