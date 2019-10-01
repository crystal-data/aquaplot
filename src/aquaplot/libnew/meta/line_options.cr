require "ecr"
require "../common/getattr"

macro create_lineoptions(options)
  class LineOptions
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

    # Custom properties
    property linecolor : String | Nil

    def get_linecolor
      if !@linecolor.nil?
        return "rgb '#{@linecolor}'"
      end
    end

    # End of custom properties

    getattr [
      {% for opt in options %}
      get_{{ opt[:name] }},
      {% end %}
      # Custom getters
      get_linecolor,
    ]

    getter fns = [
      {% for opt in options %}
      "{{ opt[:name] }}",
      {% end %}
      # Custom fns
      "linecolor"
    ]

    def initialize(
      {% for opt in options %}
      @{{ opt[:name] }}={{ opt[:default] }},
      {% end %}
      @linecolor=nil,
      )
    end

    ECR.def_to_s "src/aquaplot/libnew/templates/lineoptions_file.ecr"
  end
end

create_lineoptions [
  {name: linestyle, dtype: Union(Int32 | Nil), default: nil},
  {name: linetype, dtype: Union(Int32 | Nil), default: nil},
  {name: linewidth, dtype: Union(Int32, Nil), default: nil},
]
