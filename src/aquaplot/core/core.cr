require "./plotter"
require "./plotrange"
require "./title"
require "./canvas"

module Core
  include PlotterModule
  include TitleModule
  include PlotRangeModule
  include CanvasModule
end
