require "./figures/function"
require "./figures/line"
require "./figures/scatter"
require "./plot/plot2d"
require "./plot/plot3d"

module CoreModule
  include FunctionModule
  include LineModule
  include ScatterModule
  include PlotModule
  include Plot3DModule
end
