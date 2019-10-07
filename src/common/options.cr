require "./exceptions"

class AquaPlot::Util::Offset
  property left : Int32 | Float64
  property right : Int32 | Float64
  property top : Int32 | Float64
  property bottom : Int32 | Float64
  property key : String

  def initialize(
    @left = 0,
    @right = 0,
    @top = 0,
    @bottom = 0,
    @key = ""
  )
  end

  def set_key(@key)
  end

  def to_s
    if key.empty?
      raise AquaPlot::Exceptions::KeyError.new("Offsets was provided an empty key")
    end
    els = [@left, @right, @top, @bottom]
    nonzero = els.index { |e| e != 0 }
    if nonzero
      return "set #{key} #{els.join(", ")}"
    end
  end
end

class AquaPlot::Util::XY
  property x : Int32 | Float64
  property y : Int32 | Float64
  property key : String

  def initialize(@x = 0, @y = 0, @key = "")
  end

  def set_key(@key)
  end

  def to_s
    if key.empty?
      raise AquaPlot::Exceptions::KeyError.new("Option was provided an empty key")
    end
    if (@x != 0) & (@y != 0)
      return "set #{key} #{x}, #{y}"
    end
  end

  def to_range
    if key.empty?
      raise AquaPlot::Exceptions::KeyError.new("Range was provided an empty key")
    end
    if (@x != 0) & (@y != 0)
      return "set #{key} [#{x}:#{y}]"
    end
  end
end
