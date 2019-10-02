require "../meta/line_options"
require "uuid"

module LineModule
  include LineOptionsModule

  class Line(T) < LineOptions
    property filename : String
    property style : String = "lines"

    def set_style(@style)
    end

    def set_function(line : Array(T))
    end

    def initialize(line : Array(T), @style = "lines", **options)
      super(**options)
      @filename = "/tmp/#{UUID.random.to_s}"
      File.write(@filename, line.join("\n"))
    end

    def to_s
      parent = super
      return "'#{@filename}' with #{style} #{parent}"
    end
  end
end
