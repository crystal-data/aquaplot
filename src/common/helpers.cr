require "./exceptions"
require "uuid"

# Creates a data file containing a one-dimensional
# dataset and an optional header.
#
# `arr` : `Indexable(Number)`
# - A one dimensional array of values
# `filename` : `String`
# - location to write data
# `header` : `String | Nil`
# - optional header for the data file
# `sep` : `String`
# - line separator for files
def _create_data_file(
  arr : Indexable(Number),
  filename : String,
  header : String | Nil = nil,
  linesep = "\n"
)
  f = File.open(filename, "w")

  # writes header if needed
  if !header.nil?
    f << "##{header}#{linesep}"
  end

  # write delimited data
  f << arr.join(linesep)
  f.close
end

# Creates a data file containing a one-dimensional
# dataset and an optional header.
#
# `arr` : `Indexable(Indexable(Number))`
# - A one dimensional array of values
# `filename` : `String`
# - location to write data
# `headers` : `Indexable(String)`
# - optional header for the data file
# `sep` : `String`
# - line separator for files
def _create_data_file(
  arr : Indexable(Indexable(Number)),
  filename : String,
  headers : Indexable(String) = [] of String,
  sep = "    ",
  linesep = "\n"
)
  has_header = headers.size > 0

  if has_header
    hz = headers.size
    jagged = !arr.all? { |row| row.size == hz }
    if jagged
      raise AquaPlot::Exceptions::ShapeError.new("Shape mismatch when comparing headers to values")
    end
  end

  f = File.open(filename, "w")

  if has_header
    f << "##{headers.join(sep)}#{linesep}"
  end
  arr.each do |e|
    f << "#{e.join(sep)}#{linesep}"
  end
  f.close
end

# Returns information to create a temporary file.
# Currently this only supports unix temporary folder,
# but whenever Crystal gets ported to windows having
# this implementation in a single place will be nice.
#
# `tmppath` : `String`
# - temporary path to place temporary file
def _temporary_file(tmppath = "/tmp/")
  if !Dir.exists?(tmppath)
    raise AquaPlot::Exceptions::DirectoryNotFoundError.new("The directory #{tmppath} does not exist")
  end

  fname = UUID.random.to_s
  "#{tmppath}#{fname}"
end

# Cleans up the temporary file left by a dataset
# which generally should be run on the closing of
# a plot.  If these are not deleted, they will be
# deleted whenever the operating system clears temporary
# files
#
# `dataset` : `DataSet`
# - the object to clean up
def _cleanup_dataset(dataset)
  if dataset.cleanup
    if File.exists?(dataset.filename)
      File.delete(dataset.filename)
    end
  end
end

# Formats a string option into a valid configuration
# option for gnuplot
#
# `key` : `String`
# - Name of the option
# `value` : `String`
# - value of the option
# `quotes` : `Bool`
# - necessary if an option requires quotes
def _option_to_string(key : String, value : String | Nil, quotes = false)
  if !"#{value}".empty?
    prop = quotes ? "'#{value}'" : value
    return "#{key} #{prop}"
  end
end

# Formats a string option into a valid configuration
# option for gnuplot
#
# `key` : `String`
# - Name of the option
# `value` : `Number`
# - value of the option
# `quotes` : `Bool`
# - necessary if an option requires quotes
def _option_to_string(key : String, value : Number, quotes = false)
  if value > 0
    prop = quotes ? "'#{value}'" : value
    return "#{key} #{prop}"
  end
end

# Formats a string setting into a valid configuration
# setting for gnuplot
#
# `key` : `String`
# - Name of the option
# `value` : `String`
# - value of the option
# `quotes` : `Bool`
# - necessary if a setting requires quotes
def _setting_to_string(key : String, value : String | Nil, quotes = false)
  if !"#{value}".empty?
    prop = quotes ? "'#{value}'" : value
    return "set #{key} #{prop}"
  end
end

# Formats a numerical setting into a valid configuration
# setting for gnuplot
#
# `key` : `String`
# - Name of the option
# `value` : `Number`
# - value of the option
# `quotes` : `Bool`
# - necessary if a setting requires quotes
def _setting_to_string(key : String, value : Number, quotes = false)
  if value > 0
    prop = quotes ? "'#{value}'" : value
    return "set #{key} #{prop}"
  end
end

# Formats a boolean option into a valid configuration
# option for gnuplot
#
# `key` : `String`
# - Name of the option
# `value` : `Bool`
# - value of the option
# `quotes` : `Bool`
# - necessary if an option requires quotes
def _toggle_to_string(key : String, value : Bool)
  if value
    return "set #{key}"
  end
end

def _toggle_option_to_string(key : String, value : Bool)
  if value
    return "#{key}"
  end
end
