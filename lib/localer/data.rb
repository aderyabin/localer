# frozen_string_literal: true

require_relative "data/service"
require_relative "data/processor"

module Localer
  # Stores translations and provides
  # check methods
  class Data
    extend Dry::Initializer
    param :source, default: -> { {} }
    param :config, default: -> { Localer.config }

    attr_reader :translations, :locales

    def initialize(*args)
      super
      @locales, @translations = Processor.call(source, config)
    end

    def complete?
      each do |_locale, _key, value|
        return false if value.nil?
      end
      true
    end

    def missing_translations
      missing = []
      each do |locale, key, value|
        missing.push("#{locale}#{key}") if value.nil?
      end
      missing
    end

    def each
      @translations.each do |key, value|
        @locales.each do |locale|
          yield locale, key, value[locale]
        end
      end
    end
  end
end
