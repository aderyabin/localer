# frozen_string_literal: true

require_relative "data/service"
require_relative "data/checker"
require_relative "data/processor"
require_relative "data/missing_translations"

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
      Checker.call(self)
    end

    def missing_translations
      MissingTranslations.call(self)
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
