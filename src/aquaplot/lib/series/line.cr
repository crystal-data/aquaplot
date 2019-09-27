require "../common/style"
require "uuid"

class Line(T) < LineStyle
  @data : Array(T)
  @title : String
  @id : String

  def initialize(@data : Array(T), @title : String = "line", **options)
    @id = UUID.random.to_s.gsub(/[^a-z]/, "")
    super(**options)
  end

  def get_data
    ["$#{@id} << EOD\n#{@data.join("\n")}\nEOD\n"]
  end

  def commands
    s = super
    s[0] = "$#{@id} " + s[0] + " title '#{@title}'"
    s
  end
end
