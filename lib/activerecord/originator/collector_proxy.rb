# frozen_string_literal: true

module ActiveRecord
  module Originator
    # This class is a proxy to deduplicate the originator comment.
    class CollectorProxy
      attr_accessor :preparable

      def initialize(collector)
        @collector = collector
        @last_str = nil
      end

      attr_reader :last_str

      def <<(str)
        @collector << str
        @last_str = str
        self
      end

      def add_bind(...)
        @collector.add_bind(...)
        self
      end

      def add_binds(...)
        @collector.add_binds(...)
        self
      end

      def value
        @collector.value
      end
    end
  end
end
