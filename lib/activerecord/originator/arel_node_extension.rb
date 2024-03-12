# frozen_string_literal: true

module ActiveRecord
  module Originator
    module Extensions
      module ArelNode
        def initialize
          super
          @ar_originator_backtrace = caller
        end

        attr_reader :ar_originator_backtrace
      end
    end
  end
end
