require "./aquaplot/core"

module AquaPlot
  VERSION = "0.1.0"
  include CoreModule
end

fig1 = AquaPlot::Function.new "x**2 + y**2"
fig2 = AquaPlot::Function.new "x**2 - y**2"

plot = AquaPlot::Plot3D.new [fig1, fig2]
plot.set_title("Basic 3D Plot")
plot.set_key("right box title 'Functions'")
plot.show
