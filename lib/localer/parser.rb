# frozen_string_literal: true

module Localer
  # Parse translations into hash:
  # key: translation key
  # value: hash of locale values
  class Parser < Service
    param :translations
    param :config, default: -> { Localer.config }

    attr_reader :data, :locales

    def call
      @data = {}
      @locales = []
      @translations.each do |(locale, translation)|
        @locales.push locale
        compare(locale, translation)
      end

      self
    end

    private

    def compare(locale, translation, prefix = "")
      if translation.is_a?(Hash)
        translation.each do |(key, value)|
          full_key = prefix + ".#{key}"
          next if full_key.start_with?(*config.exclude)
          compare(locale, value, full_key)
        end
      else
        @data[prefix] ||= {}
        @data[prefix][locale] = translation
      end
    end
  end
end
