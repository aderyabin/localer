# frozen_string_literal: true

module Localer
  class Data
    # Check missing translations
    # Returns true if no missing translations found, otherwise false
    class Checker < Service
      param :data

      def call
        data.each do |_locale, _key, value|
          return false if value.nil?
        end
        true
      end
    end
  end
end
