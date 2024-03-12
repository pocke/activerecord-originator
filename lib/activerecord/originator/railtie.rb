# frozen_string_literal: true

require 'active_support/lazy_load_hooks'

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Originator.backtrace_cleaner = Rails.backtrace_cleaner
end
