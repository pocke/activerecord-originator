# frozen_string_literal: true

require 'active_record'
require 'active_support/core_ext/module/attribute_accessors'

require_relative "originator/version"

require_relative "originator/arel_node_extension"
require_relative "originator/arel_visitor_extension"
require_relative "originator/collector_proxy"

Arel::Nodes::Node.include ActiveRecord::Originator::ArelNodeExtension
Arel::Visitors::ToSql.prepend ActiveRecord::Originator::ArelVisitorExtension

module ActiveRecord
  module Originator
    mattr_accessor :backtrace_cleaner
  end
end

require_relative "originator/railtie" if defined?(Rails)