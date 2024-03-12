# frozen_string_literal: true

module ActiveRecord
  module Originator
    module ArelVisitorExtension
      def accept(object, collector)
        super(object, CollectorProxy.new(collector))
      end

      private

      %i[
        visit_Arel_Nodes_Ascending
        visit_Arel_Nodes_Descending
        visit_Arel_Nodes_Equality
        visit_Arel_Nodes_InnerJoin
      ].each do |method_name|
        define_method(method_name) do |o, collector|
          comment = originator_comment(o)
          res = super(o, collector)
          res << comment if comment && !collector.last_str.end_with?(comment)
          res
        end
      end

      def originator_comment(o)
        frame = Originator.backtrace_cleaner.clean(o.ar_producer_backtrace).first
        return unless frame

        " /* #{frame} */\n"
      end
    end
  end
end
