# frozen_string_literal: true

require_relative "localer/version"
require_relative "localer/service"
require_relative "localer/parser"
require_relative "localer/checker"
require_relative "localer/config"
require_relative "localer/missing_translations"

module Localer # :nodoc:
  class << self
    def parcer
      @parcer ||= begin
        require File.expand_path("config/environment", Dir.pwd)
        I18n.backend.send(:init_translations)
        Parser.call(I18n.backend.send(:translations))
      end
    end

    # returns array of available locales
    def locales
      parcer.locales
    end

    def data
      parcer.data
    end

    # checks missing translations
    def complete?
      Checker.call(locales, data)
    end

    # returns array of missing translations
    def missing_translations
      MissingTranslations.call(locales, data)
    end

    def config
      @config ||= Config.call
    end

    def each_data
      data.each do |key, value|
        locales.each do |locale|
          yield locale, key, value[locale]
        end
      end
    end
  end
end
