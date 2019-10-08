require "./base"
require "../common/helpers"
require "../common/exceptions"

class AquaPlot::Line < AquaPlot::XorXY
  def show_points
    @style = "linespoints"
  end

  def hide_points
    @style = "lines"
  end
end

class AquaPlot::Line3D < AquaPlot::XYZ
  def show_points
    @style = "linespoints"
  end

  def hide_points
    @style = "lines"
  end
end
