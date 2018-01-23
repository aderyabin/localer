# frozen_string_literal: true

module Localer
  # A service that returns array of missing translations
  class MissingTranslations < Service
    def call
      missing = []
      Localer.each_data do |locale, key, value|
        missing.push("#{locale}#{key}") if value.nil?
      end
      missing
    end
  end
end
