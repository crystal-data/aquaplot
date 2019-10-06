require "./base"
require "../common/helpers"
require "../common/exceptions"

class AquaPlot::Line < AquaPlot::XorXY
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

class AquaPlot::Line3D < AquaPlot::XYZ
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
