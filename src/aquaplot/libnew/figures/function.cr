require "../meta/line_options"

class Function < LineOptions
  property function : String
  property style : String = "lines"

  def set_style(@style)
  end

  def set_function(@function)
  end

  def initialize(@function, @style="lines", **options)
    super(**options)
  end

  def to_s
    parent = super
    return "#{function} with #{style} #{parent}"
  end
end
