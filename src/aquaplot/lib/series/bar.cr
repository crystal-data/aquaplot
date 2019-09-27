require "../common/style"
require "../common/option"
require "uuid"

class Bar(T) < BarStyle
  @xdata : Array(T)
  @ydata : Array(String) | Array(Int32) | Array(Float64)
  @title : String
  @id : String

  def initialize(
    @xdata : Array(T),
    @title : String = "bar",
    @settings = [Option.new "boxwidth", 0.75],
    **options
    )
    @id = UUID.random.to_s.gsub(/[^a-z]/, "")
    @ydata = (0...@xdata.size).to_a
    super(**options)
  end

  def initialize(
    @xdata : Array(T),
    @ydata,
    @title : String = "bar",
    @settings = [Option.new "boxwidth", 0.75],
    **options
    )
    @id = UUID.random.to_s.gsub(/[^a-z]/, "")
    super(**options)
  end

  def get_data
    dat = [@ydata, @xdata].transpose
    dat = dat.map do |el|
      el.join(" ")
    end.join("\n")
    ["$#{@id} << EOD\n#{dat}\nEOD\n"]
  end


  def commands
    s = super
    s[0] = "$#{@id} " + s[0] + "using 2:xtic(1) title '#{@title}'"
    s
  end
end
