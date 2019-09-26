require "uuid"

module BarBaseModule
  abstract class BarBase

    property boxwidth : Float64 | Int32 = 1
    property style : Array(String) = ["fill solid", "data histograms"]

    def initialize(@boxwidth = 1, @style = ["fill solid", "histogram clustered gap 0.5"])
    end

    def parse_boxwidth
      "set boxwidth #{boxwidth} relative"
    end

    def parse_style
      style.map do |el|
        "set style #{el}"
      end.join("; ")
    end

    def to_config
      [
        parse_boxwidth,
        parse_style,
      ]
    end
  end

  class ArrayBar(T) < BarBase
    property labels : Array(Int32) | Array(String) | Array(Float64)
    property data : Array(Array(T))

    def initialize(@data : Array(Array(T)), @labels, **options)
      super(**options)
    end

    def initialize(data : Array(T), @labels, **options)
      super(**options)
      @data = [data]
    end

    def join_xy_data
      combined = [labels] + data
      lines = combined.transpose.map do |el|
        el.join("    ")
      end
      return lines.join("\n") + "\n"
    end

    def to_config
      sup = super
      id = UUID.random.to_s
      fname = "/tmp/#{id}.dat"
      formatted = join_xy_data
      File.write(fname, formatted)
      plots = data.map_with_index do |el, i|
        "'#{fname}' using #{i+2}:xtic(1) with boxes notitle"
      end.join(", ")
      sup.push("plot #{plots}")
      puts sup
      return sup
    end
  end
end
