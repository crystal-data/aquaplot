require "../common/helpers"

class AquaPlot::Util::OffsetXY
  private property x : Int32 | Nil
  private property y : Int32 | Nil

  def initialize(@x = nil, @y = nil)
  end

  def update(@x, @y)
  end

  def to_s
    if !@y.nil? & !@x.nil?
      return "#{@x},#{@y}"
    end
  end
end
