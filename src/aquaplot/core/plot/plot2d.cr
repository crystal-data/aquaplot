require "./base"

module Plot2DModule
  include PlotBaseModule
  class Plot(T) < PlotBase(T)
    def to_s
      figs = @figures.map do |fig|
        fig.to_s
      end.join(", ")

      return "#{super}\nplot#{figs}"
    end
  end
end
