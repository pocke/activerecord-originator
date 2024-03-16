class Post < ActiveRecord::Base
  has_many :comments

  scope :hello, -> { where(title: "hello") }
  scope :draft, -> { where(state: "draft") }
  scope :state_for, ->(state) { where(state: state) }
  scope :not_state_for, ->(state) { where.not(state: state) }
  scope :compare_id, ->(range) { where(id: range) }
  scope :not_eq, ->(title) { where.not(title: title) }
  scope :order_by_title, ->(direction) { order(title: direction) }
end
