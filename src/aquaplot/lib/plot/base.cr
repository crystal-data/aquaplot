require "../canvas/base"
require "../series/bar"
require "uuid"

class Plot(T) < ConfigurationObject
  property series : Array(T)
  property canvas : Canvas = QtCanvas.new
  property title : String = ""

  def initialize(@series : Array(T), @title = "", @canvas = QtCanvas.new)
  end

  def initialize(series : T, @title = "", @canvas = QtCanvas.new)
    @series = [series]
  end

  def set_title(title, size = 10)
    @title = "'#{title}'"
  end

  def get_title
    if !@title.empty?
      return "set title #{@title}"
    end
    ""
  end

  def get_series
    ss = @series.map { |ser| ser.commands.join(" ") }
    "plot #{ss.join(", ")}"
  end

  def show
    fname = "/tmp/#{UUID.random.to_s}"
    File.write(fname, commands.join("\n"))
    gnuplot_dispatch(fname)
    File.delete(fname)
  end

  private def gnuplot_dispatch(fname)
    Process.run("gnuplot -p #{fname}", shell: true)
  end

  def commands
    config = canvas.commands
    config.push(get_title)
    series.each do |ser|
      config += ser.get_data
      config += ser.get_settings
    end
    config.push(get_series)
    puts config.join("\n")
    return config
  end
end

bar = Bar.new [5, 3, 7, 2], ["January", "February", "March", "April"]

plt = Plot.new bar
plt.set_title("Sample Plot")
plt.show
