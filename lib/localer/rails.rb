# frozen_string_literal: true

module Localer
  module Rails # :nodoc:
    class << self
      def connect!
        require File.expand_path("config/environment", Localer.config.app_path)
        true
      rescue LoadError
        false
      end

      def translations
        return {} unless connect!

        I18n.backend.send(:init_translations)
        I18n.backend.send(:translations)
      end
    end
  end
end
