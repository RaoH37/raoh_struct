# frozen_string_literal: true

module Raoh
  module Struct
    class AttributeOption
      attr_reader :attr_name, :attr_type, :options

      def initialize(attr_name, attr_type, options = {})
        @attr_name = attr_name
        @attr_type = attr_type
        @options = options
      end

      def instance_variable_key
        @instance_variable_key ||= "@_#{@attr_name}".to_sym
      end
    end
  end
end
