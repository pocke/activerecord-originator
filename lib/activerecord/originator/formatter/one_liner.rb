# frozen_string_literal: true

module ActiveRecord
  module Originator
    module Formatter
      module OneLiner
        def self.format(comment)
          " /* <- #{comment} */"
        end
      end
    end
  end
end
