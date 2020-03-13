# frozen_string_literal: true

require_relative '../ext/string'
module Localer # :nodoc:
  using Localer::Ext::String

  class Data
    # Parse translations into hash:
    # key: translation key
    # value: hash of locale values
    class Processor < Service
      param :translations
      param :config, default: -> { Localer.config }

      attr_reader :data, :locales

      def call
        @data = Hash.new { |hsh, key| hsh[key] = {} }
        @locales = []
        translations.each do |(locale, translation)|
          next unless config.locale[locale.downcase].enabled
          @locales.push locale
          prepare(locale, translation)
        end
        [@locales, @data]
      end

      private

      def prepare(locale, translation, prefix = "")
        if translation.is_a?(Hash)
          translation.each do |(key, value)|
            full_key = prefix + ".#{key}"
            next if exclude?(full_key, locale)
            prepare(locale, value, full_key)
          end
        else
          # @data[prefix] ||= {}
          @data[prefix][locale] = translation
        end
      end

      def exclude?(key, locale)
        (config.exclude + config.locale[locale.downcase].exclude).any? do |pattern|
          match?(key, pattern)
        end
      end

      def match?(key, pattern)
        if (regex = pattern.to_regexp)
          key =~ regex
        else
          key.start_with?(pattern)
        end
      end
    end
  end
end
