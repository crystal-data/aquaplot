# aquaplot

AquaPlot is a data visualization library for [crystal-lang](https://crystal-lang.org/).  It provides an easy to user interface to create visually
appealing charts.  This project is currently in extremely unstable and active development.  Contributions are both welcomed and encourages,
to get this library to a stable and useful state.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     aquaplot:
       github: crystal-data/aquaplot
   ```

2. Run `shards install`

## Usage

Gnuplot is required.  Please review your operating system's installation
instructions to install the library.

```crystal
require "aquaplot"
```

Here is a minimal example to create a chart from trigonometric functions:

```crystal
figs = ["sin(x)", "tan(x)", "cos(x)"].map { |en| AquaPlot::Function.new fn, linewidth: 3}
plot = AquaPlot::Plot.new figs
plot.set_title("Example AquaPlot Chart")
plot.set_key("left box")
plot.show
```

![aquaplot chart](./static/example_functions.png)





## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/crystal-data/aquaplot/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Zimmerman](https://github.com/christopherzimmerman) - creator and maintainer
