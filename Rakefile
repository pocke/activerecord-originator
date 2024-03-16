# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task :steep do
  sh 'steep', 'check'
end

task default: %i[rubocop steep spec]

namespace :benchmark do
  task :to_sql do
    puts "# Benchmarking #to_sql mehtod"
    puts
    puts "## Wihtout AR::Originator"
    sh 'ruby', 'benchmark/to_sql.rb'

    puts
    puts "## With AR::Originator"
    sh 'ruby', '-r', 'activerecord/originator', 'benchmark/to_sql.rb'
  end

  task :select_query do
    puts "# Benchmarking SELECT Query"
    puts
    puts "## Wihtout AR::Originator"
    sh 'ruby', 'benchmark/select_query.rb'

    puts
    puts "## With AR::Originator"
    sh 'ruby', '-r', 'activerecord/originator', 'benchmark/select_query.rb'
  end
end
task benchmark: %i[benchmark:to_sql benchmark:select_query]
