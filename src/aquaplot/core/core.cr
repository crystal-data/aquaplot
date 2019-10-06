require "./plot/plot2d"
require "./plot/plot3d"
require "./series/function"
require "./series/line"
require "./series/scatter"
require "./series/bar"

module CoreModule
  include Plot2DModule
  include Plot3DModule
  include FunctionModule
  include LineModule
  include ScatterModule
  include BarModule
end
