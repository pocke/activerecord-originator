# frozen_string_literal: true

module ActiveRecord
  module Originator
    module ArelVisitorExtension
      def accept(object, collector)
        super(object, CollectorProxy.new(collector))
      end

      private

      %i[
        Ascending
        Descending
        Equality
        NotEqual
        InnerJoin
        HomogeneousIn
        GreaterThanOrEqual
        GreaterThan
        LessThan
        LessThanOrEqual
        GreaterThanOrEqual
      ].each do |klass_name|
        define_method(:"visit_Arel_Nodes_#{klass_name}") do |o, collector|
          __skip__ = begin
            comment = originator_comment(o)
            res = super(o, collector)
            if comment && !collector.last_str.end_with?(comment)
              res << comment if comment && !collector.last_str.end_with?(comment)
            end
            res
          end
        end
      end

      def originator_comment(o)
        traces = o.ar_originator_backtrace
        if c = Originator.backtrace_cleaner
          traces = c.clean(traces)
        end
        frame = traces.first
        return unless frame

        " /* #{escape_comment(frame)} */\n"
      end

      def escape_comment(comment)
        while comment.include?('/*') || comment.include?('*/')
          comment = comment.gsub('/*', '').gsub('*/', '')
        end
        comment
      end
    end
  end
end
