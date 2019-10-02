require "../meta/point_options"
require "uuid"

module ScatterModule
  include PointOptionsModule

  class Scatter < PointOptions
    property filename : String
    property style : String = "points"

    def set_style(@style)
    end

    def initialize(x : Indexable, y : Indexable, @style = "points", **options)
      arr = [x, y].transpose.map do |el|
        el.join("  ")
      end.join("\n")
      super(**options)
      @filename = "/tmp/#{UUID.random.to_s}"
      File.write(@filename, arr)
    end

    def to_s
      parent = super
      return "'#{@filename}' with #{style} #{parent}"
    end
  end
end
