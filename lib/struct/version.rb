# frozen_string_literal: true

module Raoh
  module Struct
    def self.gem_version
      Gem::Version.new VERSION::STRING
    end

    module VERSION
      MAJOR = 0
      MINOR = 1
      TINY  = 0

      STRING = [MAJOR, MINOR, TINY].compact.join('.')
    end
  end
end
