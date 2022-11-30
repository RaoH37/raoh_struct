# frozen_string_literal: true

module Raoh
  module Struct
    class Base
      class << self
        def attributes
          @attributes ||= []
        end

        def attribute(attr_name, attr_type, options = {})
          define_attribute_method(AttributeOption.new(attr_name, attr_type, options))
        end

        private

        def define_attribute_method(recorded_attribute)
          attributes << recorded_attribute

          define_attribute_getter_method(recorded_attribute)
          define_attribute_has_changed_method(recorded_attribute)
          define_attribute_has_was_method(recorded_attribute)
          define_attribute_setter_method(recorded_attribute)
        end

        def define_attribute_getter_method(recorded_attribute)
          class_eval <<-CODE, __FILE__, __LINE__ + 1
            def #{recorded_attribute.attr_name}
              @_#{recorded_attribute.attr_name}.get
            end
          CODE
        end

        def define_attribute_has_changed_method(recorded_attribute)
          class_eval <<-CODE, __FILE__, __LINE__ + 1
            def #{recorded_attribute.attr_name}_changed?
              @_#{recorded_attribute.attr_name}.changed?
            end
          CODE
        end

        def define_attribute_has_was_method(recorded_attribute)
          class_eval <<-CODE, __FILE__, __LINE__ + 1
            def #{recorded_attribute.attr_name}_was
              @_#{recorded_attribute.attr_name}.was
            end
          CODE
        end

        def define_attribute_setter_method(recorded_attribute)
          class_eval <<-CODE, __FILE__, __LINE__ + 1
            def #{recorded_attribute.attr_name}=(value)
              @_#{recorded_attribute.attr_name}.set(value)
            end
          CODE
        end
      end

      def initialize
        define_attribute_variables
        yield(self) if block_given?
      end

      private

      def define_attribute_variables
        self.class.attributes.each do |recorded_attribute|
          attr = Raoh::Attribute.new(recorded_attribute.attr_type, recorded_attribute.options)
          instance_variable_set(recorded_attribute.instance_variable_key, attr)
        end
      end
    end
  end
end
