ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
    t.string :title, null: false
    t.string :state, null: false
  end

  create_table :comments, force: true do |t|
    t.integer :post_id
  end
end
