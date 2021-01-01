require 'zlib'

require "minisplit/version"

module Minisplit
  class Error < StandardError; end

  module ConditionalRunning
    def run
      return super if Minisplit.run?(self)

      Minitest::Result.from(self)
    end
  end

  class << self
    def run?(runnable)
      split_key_for(runnable) % split_count == current_split
    end

    private

    def current_split
      ENV.fetch('MINISPLIT_INDEX', 0).to_i
    end

    def split_count
      ENV.fetch('MINISPLIT_TOTAL', 1).to_i
    end

    def split_key_for(runnable)
      # Use a non-cryptographic hash function:
      Zlib.crc32(runnable.name)
    end
  end
end
