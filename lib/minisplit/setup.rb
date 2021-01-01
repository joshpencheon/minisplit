require 'minitest'
require_relative '../minisplit'

Minitest::Runnable.runnables.each do |runnable|
  runnable.prepend(Minisplit::ConditionalRunning)
end
