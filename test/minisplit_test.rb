require "test_helper"

describe Minisplit do
  let(:index) { nil }
  let(:total) { nil }

  subject { dummy_output('MINISPLIT_INDEX' => index.to_s, 'MINISPLIT_TOTAL' => total.to_s) }

  describe "running without control variables" do
    it "should not interfere" do
      _(subject).must_match(/5 runs, 5 assertions/)
    end
  end

  describe "running with a total variable" do
    let(:total) { 5 }

    it "should run the initial partition" do
      _(subject).must_match(/5 runs, 2 assertions/)
    end

    describe "and the index variable" do
      let(:index) { 1 }

      it "should run the specified partition" do
        _(subject).must_match(/5 runs, 1 assertions/)
      end
    end
  end

  def dummy_output(env)
    original_env = ENV.to_hash

    # Allow us to blank out existing variables, if we're dogfooding
    # and this suite is itself running via minisplit:
    env.each do |key, value|
      ENV.delete(key) if value.nil?
    end

    cmd = "bundle exec ruby test/dummy/dummy_test.rb"
    IO.popen(env, cmd) { |f| f.read }
  ensure
    ENV.replace(original_env)
  end
end
