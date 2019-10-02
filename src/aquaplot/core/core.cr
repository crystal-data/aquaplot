require "./figures/function"
require "./figures/line"
require "./plot/plot2d"
require "./plot/plot3d"

module CoreModule
  include FunctionModule
  include LineModule
  include PlotModule
  include Plot3DModule
end
