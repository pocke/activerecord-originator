require 'active_record'
require 'benchmark/ips'

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(File::NULL)
ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
    t.string :title, null: false
    t.string :state, null: false
    t.integer :comments_count, default: 0
    t.integer :likes_count, default: 0
  end
end

class Post < ActiveRecord::Base
end

Benchmark.ips do |x|
  x.report("without where") { Post.all.to_sql }
  x.report('with single condition') { Post.where(title: 'hello').to_sql }
  x.report('with multiple condition') { Post.where(title: 'hello', state: 'draft', comments_count: 42, likes_count: 43).to_sql }
end
