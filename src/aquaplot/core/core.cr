require "./figures/function"
require "./plot/plot2d"
require "./plot/plot3d"

module CoreModule
  include FunctionModule
  include PlotModule
  include Plot3DModule
end
