# frozen_string_literal: true

module Localer
  class Config
    # Provide config for locale
    class Locale
      extend Dry::Initializer
      option :exclude, default: -> { [] }
      option :enabled, default: -> { true }
    end
  end
end
