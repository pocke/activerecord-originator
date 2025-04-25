# frozen_string_literal: true

module ActiveRecord
  module Originator
    module Formatter
      module Default
        def self.format(comment)
          " /* #{comment} */\n"
        end
      end
    end
  end
end
