require "ecr"
require "../common/getattr"

module PointOptionsModule
  macro create_pointoptions(options)
    class PointOptions
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

      # Custom properties
      property linecolor : String | Nil
      property title : String | Nil

      def get_linecolor
        if !@linecolor.nil?
          return "rgb '#{@linecolor}'"
        end
      end

      def get_title
        if !@title.nil?
          return "'#{@title}'"
        end
      end

      def set_linecolor(@linecolor)
      end

      def set_title(@title)
      end

      # End of custom properties

      getattr [
        {% for opt in options %}
        get_{{ opt[:name] }},
        {% end %}
        # Custom getters
        get_linecolor,
        get_title,
      ]

      getter fns = [
        {% for opt in options %}
        "{{ opt[:name] }}",
        {% end %}
        # Custom fns
        "linecolor",
        "title",
      ]

      def initialize(
        {% for opt in options %}
        @{{ opt[:name] }}={{ opt[:default] }},
        {% end %}
        @linecolor=nil,
        @title=nil,
        )
      end

      def to_s
        line = ""
        @fns.each do |fn|
          func = getattr("get_#{fn}")
          if func
            line += " #{fn} #{func}"
          end
        end
        return line
      end
    end
  end

  create_pointoptions [
    {name: pointstyle, dtype: Union(Int32 | Nil), default: nil},
    {name: pointtype, dtype: Union(Int32 | Nil), default: 5},
    {name: pointsize, dtype: Union(Int32, Nil), default: nil},
  ]
end
