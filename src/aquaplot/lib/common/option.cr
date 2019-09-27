require "../meta/base"

class Option < ConfigurationObject
  property command : String
  property parameters : String | Int32 | Float64

  def initialize(@command, @parameters = "")
  end

  def commands
    ["set #{command} #{parameters}"]
  end
end
