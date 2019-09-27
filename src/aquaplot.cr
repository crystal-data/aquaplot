require "./aquaplot/core"

module AquaPlot
  VERSION = "0.1.0"
  include Core
end

include AquaPlot

fig = ArrayBar.new [[1, 2, 3, 4, 5], [5, 4, 3, 2, 1]], [1, 2, 3, 4, 5], boxwidth: 0.3

plt = BarPlot.new fig
plt.show
