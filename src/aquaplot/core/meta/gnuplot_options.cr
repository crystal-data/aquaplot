require "ecr"
require "../common/getattr"

module GnuOptionsModule
  macro create_gnuoptions(options)
    class GnuOptions
      {% for opt in options %}
      property {{ opt[:name] }} : {{ opt[:dtype] }}

      def set_{{ opt[:name] }}(value)
        @{{ opt[:name] }} = value
      end

      def get_{{ opt[:name] }}
        if @{{opt[:name]}}.is_a?(Bool)
          return ""
        end
        return @{{opt[:name]}}
      end
      {% end %}

      # Custom properties.  These must be all
      # added to getattr, fns, and the constructor
      # in order for the macro to work correctly
      property title : String | Nil
      property xlabel : String | Nil
      property ylabel : String | Nil
      property yrange : NamedTuple(min: Int32, max: Int32) = {min: 0, max: 0}
      property xrange : NamedTuple(min: Int32, max: Int32) = {min: 0, max: 0}

      def get_title
        if !@title.nil?
          return "'#{@title}' font ',14'"
        end
        return nil
      end

      def set_title(@title)
      end

      def get_xlabel
        if !@xlabel.nil?
          return "'#{@xlabel}'"
        end
        return nil
      end

      def set_xlabel(@xlabel)
      end

      def get_ylabel
        if !@ylabel.nil?
          return "'#{@ylabel}'"
        end
        return nil
      end

      def set_ylabel(@ylabel)
      end

      def get_yrange
        if @yrange[:min] != @yrange[:max]
          return "[#{@yrange[:min]}:#{@yrange[:max]}]"
        end
      end

      def set_yrange(min, max)
        @yrange = {min: min, max: max}
      end

      def get_xrange
        if @xrange[:min] != @xrange[:max]
          return "[#{@xrange[:min]}:#{@xrange[:max]}]"
        end
      end

      def set_xrange(min, max)
        @xrange = {min: min, max: max}
      end

      # End of custom properties

      getattr [
        {% for opt in options %}
        get_{{ opt[:name] }},
        {% end %}
        # Custom getters
        get_title,
        get_xlabel,
        get_ylabel,
        get_yrange,
        get_xrange,
      ]

      getter fns = [
        {% for opt in options %}
        "{{ opt[:name] }}",
        {% end %}
        # Custom fns
        "title",
        "xlabel",
        "ylabel",
        "yrange",
        "xrange",
      ]

      def initialize(
        {% for opt in options %}
        @{{ opt[:name] }}={{ opt[:default] }},
        {% end %}
        @title=nil,
        @xlabel=nil,
        @ylabel=nil,
        )
      end

      def to_s
        file =\
        "
# Generated configuration file for a gnuplot.
# This is automatically generated using options
# provided by the user, however some options
# are preset by the library to support a
# distinct feel for basic graphs

set style line 1 lc rgb '#A00000'
set style line 2 lc rgb '#00A000'
set style line 3 lc rgb '#5060D0'
set style line 4 lc rgb '#0000A0'
set style line 5 lc rgb '#D0D000'
set style line 6 lc rgb '#00D0D0'
set style line 7 lc rgb '#B200B2'
        "

        @fns.each do |fn|
          func = self.getattr("get_#{fn}")
          if func
            file += "\nset #{fn} #{func}\n"
          end
        end
        return file
      end
    end
  end

  create_gnuoptions [
    {name: angles, dtype: Union(String | Nil), default: nil},
    {name: key, dtype: Union(String | Nil), default: nil},
    {name: parametric, dtype: Union(Bool | Nil), default: nil},
    {name: contour, dtype: Union(String | Nil), default: nil},
    {name: mapping, dtype: Union(String | Nil), default: nil},
    # {name: offsets, dtype: Union(Array(Int32 | Float64) | Nil), default: nil},
    {name: polar, dtype: Union(Bool | Nil), default: nil},
    {name: rrange, dtype: Union(Array(Int32 | Float64) | Nil), default: nil},
    {name: samples, dtype: Union(Int32 | Nil), default: nil},
    # {name: size, dtype: Union(Array(Int32 | Float64) | Nil), default: nil},
    {name: surface, dtype: Union(Bool | Nil), default: nil},
    {name: terminal, dtype: String, default: "qt"},
    {name: tics, dtype: Union(String | Nil), default: nil},
    {name: ticslevel, dtype: Union(Int32 | Nil), default: nil},
    {name: ticscale, dtype: Union(Int32 | Nil), default: nil},
    {name: time, dtype: Union(Bool | Nil), default: nil},
    {name: grid, dtype: Union(Bool | Nil), default: true},
    # {name: title, dtype: Union(String | Nil), default: nil},
    # {name: trange, dtype: Union(Array(Int32 | Float64) | Nil), default: nil},
    # {name: urange, dtype: Union(Array(Int32 | Float64) | Nil), default: nil},
    # {name: vrange, dtype: Union(Array(Int32 | Float64) | Nil), default: nil}
  ]
end
