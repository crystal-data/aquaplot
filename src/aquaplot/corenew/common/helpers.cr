require "./exceptions"

# Creates a data file containing a one-dimensional
# dataset and an optional header.
#
# arr : Indexable(Number)
# - A one dimensional array of values
# filename : String
# - location to write data
# header : String | Nil
# - optional header for the data file
# sep : String
# - line separator for files
def _create_data_file(
  arr : Indexable(Number),
  filename : String,
  header : String | Nil = nil,
  linesep = "\n"
)
  f = File.open(filename, "w")
  if !header.nil?
    f << "#{header}#{linesep}"
  end

  f << arr.join(linesep)
  f.close
end

# Creates a data file containing a one-dimensional
# dataset and an optional header.
#
# arr : Indexable(Indexable(Number))
# - A one dimensional array of values
# filename : String
# - location to write data
# headers : Indexable(String)
# - optional header for the data file
# sep : String
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
    inner = arr.map { |el| el.size }
    hz = headers.size
    jagged = inner.index { |el| el != hz }
    if !jagged.nil?
      raise ShapeError.new("Shape mismatch when comparing headers to values")
    end
  end

  f = File.open(filename, "w")

  if has_header
    f << "#{headers.join(sep)}#{linesep}"
  end
  arr.each do |e|
    f << "#{e.join(sep)}#{linesep}"
  end
  f.close
end
