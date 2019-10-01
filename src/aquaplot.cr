require "./aquaplot/core"

module AquaPlot
  VERSION = "0.1.0"
  include CoreModule
end

figs = ["sin(x)", "tan(x)", "cos(x)"].map { |fn| AquaPlot::Function.new fn, linewidth: 3}
plot = AquaPlot::Plot.new figs
plot.set_title("Example AquaPlot Chart")
plot.set_key("left box")
plot.show
