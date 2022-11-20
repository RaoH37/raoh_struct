# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'raoh_struct'

require 'minitest/autorun'

module Sample

  class TestUser < Raoh::Struct::Base
    attribute :first_name, String
    attribute :last_name, String
    attribute :age, Integer
  end

  class TestUserWithTransform < Raoh::Struct::Base
    attribute :first_name, String, transform: %i[capitalize]
    attribute :last_name, String, transform: %i[upcase]
    attribute :age, Integer, default: 38
  end

  class << self
    def init_maxime_user(first_name, last_name, age)
      TestUser.new do |user|
        user.first_name = first_name
        user.last_name = last_name
        user.age = age
      end
    end

    def init_maxime_user_with_transform(first_name, last_name, age)
      TestUserWithTransform.new do |user|
        user.first_name = first_name
        user.last_name = last_name
        user.age = age
      end
    end
  end
end