require "./base"

struct AquaPlot::View
  getter rotation_x : Int32? = nil
  getter rotation_z : Int32? = nil
  getter scale : Float64 = 1.0

  def to_s
    "set view #{@rotation_x},#{@rotation_z},#{@scale}"
  end

  def initialize(@rotation_x : Int32? = nil, @rotation_z : Int32? = nil, @scale : Float64 = 1.0)
  end
end

class AquaPlot::Plot3D(T) < AquaPlot::PlotBase(T)
  property view : View = View.new

  def set_view(rx : Int32, ry : Int32, scale : Float64 = 1.0)
    @view = View.new(rx, ry, scale)
  end

  def to_s
    figs = @figures.map do |fig|
      fig.to_s
    end.join(", ")

    s = "#{@view.to_s}\n"

    s + "#{super}\nsplot#{figs}"
  end
end
