require "./plot/base"
require "./plotrange"
require "./title"
require "./canvas"

module Core
  include PlotBaseModule
  include TitleModule
  include PlotRangeModule
  include CanvasModule
end
