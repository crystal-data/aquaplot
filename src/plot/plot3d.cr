require "./base"

class AquaPlot::Plot3D(T) < AquaPlot::PlotBase(T)
  def to_s
    figs = @figures.map do |fig|
      fig.to_s
    end.join(", ")

    "#{super}\nsplot#{figs}"
  end
end
