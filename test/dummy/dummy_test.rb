$LOAD_PATH.unshift File.expand_path("../../lib", __dir__)

require "minisplit/setup"
require "minitest/autorun"

describe String do
  it "should upcase" do
    expect('downcase'.upcase).must_equal("DOWNCASE")
  end

  it "should downcase" do
    expect('UPCASE'.downcase).must_equal("upcase")
  end

  it "should swapcase" do
    expect('MiXeDcAsE'.swapcase).must_equal("mIxEdCaSe")
  end

  it "should reverse" do
    expect('forward'.reverse).must_equal("drawrof")
  end

  it "should delete" do
    expect('delete'.delete('e')).must_equal('dlt')
  end
end
