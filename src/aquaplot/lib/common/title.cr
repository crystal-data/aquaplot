require "../meta/base"

class Title < ConfigurationObject
  text : String = "notitle"

  def commands
    ["set title #{text}"]
  end
end
