require "./aquaplot/core"

module AquaPlot
  VERSION = "0.1.0"
  include Core
end

include AquaPlot

plt = Plotter.from_function("sin(x)", -10, 10)
plt.set_title("Sample Plot")
plt.show
