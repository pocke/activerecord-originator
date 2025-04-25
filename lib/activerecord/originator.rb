# frozen_string_literal: true

require 'active_record'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/class/subclasses'

require_relative "originator/version"

require_relative "originator/arel_node_extension"
require_relative "originator/arel_visitor_extension"
require_relative "originator/collector_proxy"
require_relative "originator/formatter"

ActiveRecord::Originator::ArelVisitorExtension::TARGET_NODE_CLASSESS.each do |name|
  begin
    klass = Arel::Nodes.const_get(name)
  rescue NameError
    # Some classes are not defined in old arel
    next
  end
  klass.prepend ActiveRecord::Originator::ArelNodeExtension
end
Arel::Visitors::ToSql.prepend ActiveRecord::Originator::ArelVisitorExtension

module ActiveRecord
  module Originator
    extend Formatter

    mattr_accessor :backtrace_cleaner
  end
end

ActiveRecord::Originator.format = :default

require_relative "originator/railtie" if defined?(Rails)
