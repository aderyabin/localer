# frozen_string_literal: true

module Localer
  # Check missing translations
  # Returns true if no missing translations found, otherwise false
  class Checker < Service
    def call
      Localer.each_data do |_locale, _key, value|
        return false if value.nil?
      end
      true
    end
  end
end
