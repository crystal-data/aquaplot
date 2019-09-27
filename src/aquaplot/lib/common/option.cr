require "../meta/base"

class Option < ConfigurationObject
  property command : String
  property parameters : String

  def initialize(@command, @parameters = "")
  end

  def commands
    ["set #{command} #{parameters}"]
  end
end
