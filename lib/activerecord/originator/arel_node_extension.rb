# frozen_string_literal: true

module ActiveRecord
  module Originator
    module ArelNodeExtension
      def initialize
        __skip__ = super
        @ar_originator_backtrace = caller
      end

      attr_reader :ar_originator_backtrace
    end
  end
end
