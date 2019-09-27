include "../meta/base"

class Function < ConfigurationObject
  property name : String
  property expression : String

  def initialize(@name, @expression)
  end

  def commands
    ["#{name} = #{expression}"]
  end
end
