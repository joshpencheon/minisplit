require "test_helper"

describe Minisplit do
  let(:env) { Hash.new }

  subject { dummy_output(env) }

  describe "running without control variables" do
    it "should not interfere" do
      _(subject).must_match(/5 runs, 5 assertions/)
    end
  end

  describe "running with a total variable" do
    let(:env) { { 'MINISPLIT_TOTAL' => '5' } }

    it "should run the initial partition" do
      _(subject).must_match(/5 runs, 2 assertions/)
    end

    describe "and the index variable" do
      let(:env) { { 'MINISPLIT_INDEX' => '1', 'MINISPLIT_TOTAL' => '5' } }

      it "should run the specified partition" do
        _(subject).must_match(/5 runs, 1 assertions/)
      end
    end
  end

  def dummy_output(env)
    cmd = "bundle exec ruby test/dummy/dummy_test.rb"
    IO.popen(env, cmd) { |f| f.read }
  end
end
