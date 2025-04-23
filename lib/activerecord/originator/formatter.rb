# frozen_string_literal: true

require_relative "formatter/default"
require_relative "formatter/one_liner"

module ActiveRecord
  module Originator
    module Formatter
      attr_reader :format, :current_formatter

      def format=(format)
        @format = format
        resolve_formatter
      end

      def resolve_formatter
        case format
        when :one_liner
          @current_formatter = OneLiner
        else
          @current_formatter = Default
        end
      end
    end
  end
end
