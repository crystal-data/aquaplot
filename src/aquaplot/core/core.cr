require "./plot/plot2d"
require "./plot/plot3d"
require "./series/function"
require "./series/line"

module CoreModule
  include Plot2DModule
  include Plot3DModule
  include FunctionModule
  include LineModule
end
