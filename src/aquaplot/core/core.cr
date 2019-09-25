require "./plotter"
require "./plotrange"
require "./title"

module Core
  include PlotterModule
  include TitleModule
  include PlotRangeModule
end
