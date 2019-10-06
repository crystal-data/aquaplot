require "./base"
require "../common/helpers"
require "../common/exceptions"

class AquaPlot::Scatter < AquaPlot::XorXY
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

class AquaPlot::Scatter3D < AquaPlot::XYZ
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
