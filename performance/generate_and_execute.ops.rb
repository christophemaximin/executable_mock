# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))

require "executable_mock"
require "benchmark"

ITERATIONS = 100

mappings = {
  "foo" => "bar"
}

total = Benchmark.realtime do
  ITERATIONS.times do
    ExecutableMock.generate("executable-name", mappings) do |mock|
      `#{mock.file_path} foo`
    end
  end
end

puts "CPU: #{`sysctl -n machdep.cpu.brand_string`}"
puts "Ruby version: #{RUBY_VERSION}"
puts "Iterations: #{ITERATIONS}"
puts "Realtime: #{total}"
puts "OPS: #{(ITERATIONS / total).round}"
