require "./base"

class AquaPlot::Plot(T) < AquaPlot::PlotBase(T)
  def to_s
    figs = @figures.map do |fig|
      fig.to_s
    end.join(", ")

    "#{super}\nplot#{figs}"
  end
end
