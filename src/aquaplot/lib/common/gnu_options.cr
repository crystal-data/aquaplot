require "ecr"

macro getattr(fns)
  def getattr(attr_name)
    {% for fn in fns %}
      if {{ fn.id.stringify }} == attr_name
        return self.{{ fn.id }}
      end
    {% end %}
  end
end

macro create_gnuoptions(options)
  class GnuOptions
    {% for opt in options %}
    property {{ opt[:name] }} : {{ opt[:dtype] }}

    def set_{{ opt[:name]}}(value)
      @{{ opt[:name] }} = value
    end

    def get_{{ opt[:name]}}
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

    def get_title
      if !@title.nil?
        return "'#{@title}'"
      end
      return nil
    end

    def get_xlabel
      if !@xlabel.nil?
        return "'#{@xlabel}'"
      end
      return nil
    end

    def get_ylabel
      if !@ylabel.nil?
        return "'#{@ylabel}'"
      end
      return nil
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
    ]

    getter fns = [
      {% for opt in options %}
      "{{ opt[:name] }}",
      {% end %}
      # Custom fns
      "title",
      "xlabel",
      "ylabel",
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

    ECR.def_to_s "src/aquaplot/lib/templates/gnuplot.ecr"
  end
end

create_gnuoptions [
  {name: angles, dtype: Union(String | Nil), default: nil },
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
  # {name: title, dtype: Union(String | Nil), default: nil},
  # {name: trange, dtype: Union(Array(Int32 | Float64) | Nil), default: nil},
  # {name: urange, dtype: Union(Array(Int32 | Float64) | Nil), default: nil},
  # {name: vrange, dtype: Union(Array(Int32 | Float64) | Nil), default: nil}
]
