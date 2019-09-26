module TitleModule
  # A class to provide a wrapper to the title configuration
  # options in gnuplot.  Currently supports text and font size.
  # Handles parsing of title options to return a valid string
  # that will be appending to the gnuplot input file
  class Title
    # Title for the plot.  If this is empty, the plot
    # is considered not to have a title
    property label : String

    # Font size of the title, If `label` is empty, this
    # will be ignored.
    property font : Int32

    # An array of arguments that will later be used to
    # pass additional keyword arguments to a Title
    # configuration.  This is currently not used
    property args = Array(String).new

    # Only a single initialize exists that takes in
    # at the very least a title.  If this is an empty
    # string the Title will not be used
    def initialize(@label, @font = 20)
    end

    # A convenience function return valid Title configuration
    # options for a gnuplot plot.  Right now this only handles
    # text and font
    def add_options
      options = Array(String).new
      if !@label.empty?
        # MUST USE SINGLE QUOTES HERE
        options.push("set title '#{label}' font ',#{font}'")
      end
      return options
    end
  end
end
