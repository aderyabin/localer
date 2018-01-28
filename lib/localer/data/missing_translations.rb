# frozen_string_literal: true

module Localer
  class Data
    # A service that returns array of missing translations
    class MissingTranslations < Service
      param :data

      def call
        missing = []
        data.each do |locale, key, value|
          missing.push("#{locale}#{key}") if value.nil?
        end
        missing
      end
    end
  end
end
