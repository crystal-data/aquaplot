require "../common/helpers"

abstract class DataSet
  #
  # PROPERTIES
  #
  property filename : String
  property cleanup : Bool = true
  property title : String = ""

  #
  # INITIALIZATION
  #
  def initialize(@title = "")
    @filename = _temporary_file
  end

  #
  # CLEANUP
  #
  def finalize
    _cleanup_dataset(self)
  end

  #
  # GETTERS
  #
  def get_title
    _option_to_string "title", @title, quotes: true
  end

  def get_filename
    _option_to_string "", @filename, quotes: true
  end

  #
  # SETTERS
  #
  def set_title(@title)
  end
end

class XorXY < DataSet
  def initialize(x : Indexable(Number), **options)
    super(**options)
    _create_data_file(x, @filename)
  end

  def initialize(x : Indexable(Number), y : Indexable(Number), **options)
    super(**options)
    _create_data_file([x, y].transpose, @filename)
  end
end
