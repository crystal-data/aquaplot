module PlotRangeModule
  # A generic class to handle a range to plot a graph.
  # Right now this only supports a `start` and `stop`
  # parameters, but abstracting this out gives a much more
  # flexible API to eventually provide better from
  # other types of data than just functions
  # TODO
  # - Implement datetime ranges and infer start and stop indexes from values
  class PlotRange

    # Start value for a range.  Currently only supports
    # Int32 values.
    property start : Int32

    # End value for a range. Currently only supports
    # Int32 values
    property stop : Int32

    # Initialization must accept an Int32 start and an
    # Int32 stop.
    def initialize(@start, @stop)
    end
  end
end
