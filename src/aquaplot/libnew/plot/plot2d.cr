require "../meta/gnuplot_options"
require "../figures/function"
require "uuid"

class Plot(T) < GnuOptions
  property figures : Array(T)

  def initialize(@figures : Array(T), **options)
    super(**options)
  end

  def initialize(figure : T, **options)
    super(**options)
    @figures = [figure]
  end

  def to_s
    parent = super
    figs = @figures.map do |fig|
      fig.to_s
    end.join(", ")
    return "#{parent}\nplot #{figs}"
  end

  def show
    id = UUID.random.to_s
    puts id
  end
end

fig = Function.new "cos(x)"
plt = Plot.new fig
plt.show
