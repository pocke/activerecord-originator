# frozen_string_literal: true

require 'logger' # For https://github.com/rails/rails/pull/54264
require "activerecord/originator"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ActiveRecord::Originator.backtrace_cleaner = ActiveSupport::BacktraceCleaner.new.tap do |bc|
  root_dir = File.expand_path("..", __dir__)
  bc.add_filter { |line| line.gsub(root_dir, "") }
  bc.add_filter { |line| line.gsub(/:in .+$/, "") }
  bc.add_silencer { |line| not line.start_with?('/spec/') }
end

Pathname(__dir__).glob('support/*.rb').each { |f| require f }
