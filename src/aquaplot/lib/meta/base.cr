abstract class ConfigurationObject
  abstract def commands
  def config
    commands.join("\n")
  end
end
