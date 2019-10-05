require "./base"

module Plot3DModule
  include PlotBaseModule
  class Plot3D(T) < PlotBase(T)
    def to_s
      figs = @figures.map do |fig|
        fig.to_s
      end.join(", ")

      return "#{super}\nsplot#{figs}"
    end
  end
end
