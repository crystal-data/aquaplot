require "../../../src/aquaplot/core/common/helpers"
require "../../../src/aquaplot/core/series/base"

TMP_PATH = "/tmp/test.dat"

describe "Helpers" do
  it "Ensure _create_data_file creates a file" do
    _create_data_file [1, 2, 3], TMP_PATH
    File.exists?(TMP_PATH).should be_true
    File.delete(TMP_PATH)
  end

  it "Ensure _create_data_file contents are correct" do
    _create_data_file [1, 2, 3], TMP_PATH
    data = File.read(TMP_PATH)
    data.should eq("1\n2\n3")
    File.delete(TMP_PATH)
  end

  it "Ensure _create_data_file contents with header" do
    _create_data_file [1, 2, 3], TMP_PATH, "X"
    data = File.read(TMP_PATH)
    data.should eq("#X\n1\n2\n3")
    File.delete(TMP_PATH)
  end

  it "Ensure _create_data_file creates 2d file" do
    _create_data_file [[1, 2], [3, 4]], TMP_PATH
    File.exists?(TMP_PATH).should be_true
    File.delete(TMP_PATH)
  end

  it "Ensure _create_data_file finds bad headers" do
    expect_raises(ShapeError) do
      _create_data_file [[1, 2], [3, 4]], TMP_PATH, ["X", "Y", "Z"]
    end
  end

  it "Ensure _create_data_file 2d contents are correct" do
    _create_data_file [[1, 2], [3, 4]], TMP_PATH
    data = File.read(TMP_PATH)
    data.should eq("1    2\n3    4\n")
    File.delete(TMP_PATH)
  end

  it "Ensure _create_data_file 2d contents are correct with header" do
    _create_data_file [[1, 2], [3, 4]], TMP_PATH, ["X", "Y"]
    data = File.read(TMP_PATH)
    data.should eq("#X    Y\n1    2\n3    4\n")
  end

  it "Ensure _temporary_file finds missing directory" do
    expect_raises(DirectoryNotFoundError) do
      _temporary_file("/aksfjsal")
    end
  end
end
