require "./base"
require "../common/helpers"

class AquaPlot::Function < AquaPlot::SeriesOptions
  #
  # PROPERTIES
  #
  property function : String

  #
  # INITIALIZATION
  #
  def initialize(@function, **options)
    super(**options)
  end

  #
  # GETTERS
  #
  def get_function
    _option_to_string "", @function
  end

  #
  # SERIALIZER
  #
  def to_s
    [
      get_function,
      get_style,
      get_linecolor,
      get_linewidth,
      get_pointtype,
      get_pointsize,
      get_title,
    ].join(" ")
  end
end
