# frozen_string_literal: true

require 'dry-initializer'
module Localer
  class Data
    # Core service object
    class Service
      extend Dry::Initializer # use `param` and `option` for dependencies

      class << self
        # Instantiates and calls the service at once
        def call(*args, &block)
          new(*args).call(&block)
        end
      end
    end
  end
end
