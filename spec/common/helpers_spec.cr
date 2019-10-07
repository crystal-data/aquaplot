require "../../src/common/helpers"
require "../../src/series/base"

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
    expect_raises(AquaPlot::Exceptions::ShapeError) do
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
    expect_raises(AquaPlot::Exceptions::DirectoryNotFoundError) do
      _temporary_file("/aksfjsal")
    end
  end

  it "Ensure _option_to_string creates valid string option" do
    option = _option_to_string "foo", "bar"
    option.should eq("foo bar")
  end

  it "Ensure _option_to_string ignores empty string option" do
    option = _option_to_string "foo", ""
    option.should be_nil
  end

  it "Ensure _option_to_string provides quotes for string option" do
    option = _option_to_string "foo", "bar", quotes: true
    option.should eq("foo 'bar'")
  end

  it "Ensure _option_to_string creates valid numeric option" do
    option = _option_to_string "foo", 2
    option.should eq("foo 2")
  end

  it "Ensure _option_to_string ignores empty numeric option" do
    option = _option_to_string "foo", -1
    option.should be_nil
  end

  it "Ensure _option_to_string provides quotes for numeric option" do
    option = _option_to_string "foo", 2, quotes: true
    option.should eq("foo '2'")
  end

  it "Ensure _setting_to_string produces a valid string setting" do
    setting = _setting_to_string "foo", "bar"
    setting.should eq("set foo bar")
  end

  it "Ensure _setting_to_string ignores empty string setting" do
    setting = _setting_to_string "foo", ""
    setting.should be_nil
  end

  it "Ensure _setting_to_string provides quotes for string setting" do
    setting = _setting_to_string "foo", "bar", quotes: true
    setting.should eq("set foo 'bar'")
  end

  it "Ensure _toggle_to_string creates an option when true" do
    toggle = _toggle_to_string "foo", true
    toggle.should eq("set foo")
  end

  it "Ensure _toggle_to_string ignores option when false" do
    toggle = _toggle_to_string "foo", false
    toggle.should be_nil
  end
end
