require "../meta/gnuplot_options"
require "../meta/line_options"
require "../figures/function"
require "uuid"

module PlotModule
  include GnuOptionsModule
  include LineOptionsModule
  include FunctionModule

  class Plot(T) < GnuOptions
    property figures : Array(T)

    def initialize(@figures : Array(T), **options)
      super(**options)
      preprocess
    end

    def preprocess
      process_style(@figures)
    end

    def process_style(figures : Array(LineOptions))
      @figures.each_with_index do |el, index|
        el.set_linestyle(index + 1)
      end
    end

    def process_style(figures : Array(PointOptions))
    end

    def initialize(figure : T, **options)
      super(**options)
      @figures = [figure]
      preprocess
    end

    def to_s
      parent = super
      figs = @figures.map do |fig|
        fig.to_s
      end.join(", ")
      return "#{parent}\nplot #{figs}"
    end

    def show
      fname = "/tmp/#{UUID.random.to_s}"
      File.write(fname, self.to_s)
      gnuplot_dispatch(fname)
      File.delete(fname)
    end

    private def gnuplot_dispatch(fname)
      stdout = IO::Memory.new
      Process.run("gnuplot -p #{fname}", shell: true, output: stdout)
      if stdout
        puts stdout
      end
    end
  end
end
