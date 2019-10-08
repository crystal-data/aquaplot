require "../common/helpers"

class AquaPlot::Util::Font
  private property family : String | Nil
  private property size : Int32 | Nil

  def initialize(@family = nil, @size = nil)
  end

  def update(@family, @size = nil)
  end

  def to_s
    size_s = "#{@size}".empty? ? "" : ",#{@size}"
    if !@family.nil?
      return "#{@family}#{size_s}"
    end
  end
end
