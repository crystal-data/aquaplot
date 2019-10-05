require "./base"
require "../series/base"
require "../series/line"

class Plot(T) < GlobalPlotOptions
  property figures : Array(T)

  def initialize(@figures : Array(T), **options)
    super(**options)
  end

  def initialize(figure : T, **options)
    super(**options)
    @figures = [figure]
  end

  def close
    @figures.each do |fig|
      fig.finalize
    end
  end

  def to_s
    figs = @figures.map do |fig|
      fig.to_s
    end.join(", ")

    return "#{super}\nplot#{figs}"
  end

  def show
    File.write(@filename, self.to_s)
    gnuplot_dispatch()
    File.delete(@filename)
  end

  private def gnuplot_dispatch
    stdout = IO::Memory.new
    Process.run("gnuplot -p #{@filename}", shell: true, output: stdout)
    if stdout
      puts stdout
    end
  end
end
