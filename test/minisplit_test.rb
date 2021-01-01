require "test_helper"

describe Minitest do
  describe "::VERSION" do
    it "should have a value"do
      expect(Minitest::VERSION).wont_be_nil
    end
  end
end
