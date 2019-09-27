require "./plot/base"
require "./plotrange"
require "./title"
require "./canvas"
require "./series/bar"

module Core
  include PlotBaseModule
  include BarBaseModule
  include TitleModule
  include PlotRangeModule
  include CanvasModule
end
