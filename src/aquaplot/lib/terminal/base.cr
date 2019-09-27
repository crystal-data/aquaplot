abstract class TerminalBase
  property term : String = ""
  def initialize
  end
end

class QtTerminal < TerminalBase
  property term = "qt"
end

class PngTerminal < TerminalBase
  property term = "png"
end
