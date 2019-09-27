require "../meta/base"
require "../terminal/base"

SIZE_X = 640
SIZE_Y = 480
SCALE_X = 1
SCALE_Y = 1

class Canvas < ConfigurationObject
  property term : TerminalBase
  property size : NamedTuple(x: Int32, y: Int32)
  property scale : NamedTuple(x: Int32, y: Int32)

  def initialize(@term, @size, @scale)
  end

  def initialize(@term = QtTerminal.new, @size = {x: SIZE_X, y: SIZE_Y}, @scale = {x: SCALE_X, y: SCALE_Y})
  end

  private def terminal_size
    "set term #{term.term} size #{size[:x]},#{size[:y]}"
  end

  private def terminal_scale
    "set size #{scale[:x]},#{scale[:y]}"
  end

  def commands
    [terminal_size, terminal_scale]
  end
end
