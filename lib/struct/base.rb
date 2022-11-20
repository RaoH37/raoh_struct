# frozen_string_literal: true

module Raoh
  module Struct
    class Base
      class << self
        def attribute(attr_name, attr_type, options = {})
          define_attribute_method(AttributeOption.new(attr_name, attr_type, options))
        end

        def define_attribute_method(recorded_attribute)
          define_attribute_getter_method(recorded_attribute)
          define_attribute_has_changed_method(recorded_attribute)
          define_attribute_has_was_method(recorded_attribute)
          define_attribute_setter_method(recorded_attribute)
        end

        def define_attribute_getter_method(recorded_attribute)
          define_method(recorded_attribute.attr_name) do |*_args|
            private_instance_variable(recorded_attribute).get
          end
        end

        def define_attribute_has_changed_method(recorded_attribute)
          method_name = "#{recorded_attribute.attr_name}_changed?"
          define_method(method_name) do |*_args|
            private_instance_variable(recorded_attribute).changed?
          end
        end

        def define_attribute_has_was_method(recorded_attribute)
          method_name = "#{recorded_attribute.attr_name}_was"
          define_method(method_name) do |*_args|
            private_instance_variable(recorded_attribute).was
          end
        end

        def define_attribute_setter_method(recorded_attribute)
          method_name = "#{recorded_attribute.attr_name}="
          define_method(method_name) do |value|
            private_instance_variable(recorded_attribute).set(value)
          end
        end
      end

      def initialize
        yield(self) if block_given?
      end

      def private_instance_variable(recorded_attribute)
        attr = instance_variable_get(recorded_attribute.instance_variable_key)
        return attr unless attr.nil?

        attr = Raoh::Attribute.new(recorded_attribute.attr_type, recorded_attribute.options)
        instance_variable_set(recorded_attribute.instance_variable_key, attr)
      end
    end
  end
end
