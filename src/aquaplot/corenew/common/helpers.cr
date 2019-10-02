# Creates a data file containing a one-dimensional
# dataset and an optional header.
#
# arr : Indexable
# - A one dimensional array of values
# filename : String
# - location to write data
# header : String | Nil
# - optional header for the data file
# sep : String
# - line separator for files
def _create_data_file(
  arr : Indexable,
  filename : String,
  header : String | Nil = nil,
  sep="\n"
)
  f = File.open(filename, "w")
  if !headers.nil?
    f << "#{header}#{sep}"
  end

  f << arr.join(sep)
  f.close
end
