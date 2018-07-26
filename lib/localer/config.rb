# frozen_string_literal: true

require 'yaml'
require_relative '../localer/ext/hash'
require_relative 'config/locale'

module Localer # :nodoc:
  using Localer::Ext::Hash

  # Loads and parse Localer config file `.localer.yml`
  class Config
    extend Dry::Initializer

    APP_PATH = Dir.pwd
    CONFIG_FILENAME = ".localer.yml"

    option :exclude, default: -> { [] }
    option :locale, proc { |hash| parse_locales(hash) }, default: -> { Hash.new(Locale.new) }
    option :app_path, default: -> { APP_PATH }

    class << self
      def load(options = {})
        opts = options.deep_symbolize_keys
        app_path = opts.fetch(:app_path, APP_PATH)
        file_options = file_config(CONFIG_FILENAME, app_path)
        new(file_options.deep_merge(opts).deep_symbolize_keys)
      end

      def file_config(filename, path)
        filename = File.expand_path(filename, path)
        return {} unless File.exist?(filename)
        return {} if File.zero?(filename)
        YAML
          .load_file(filename)
          .deep_downcase_keys
          .deep_symbolize_keys
      end

      def parse_locales(hash)
        hash.each_with_object(Hash.new(Locale.new)) do |(l, v), h|
          h[l] = Locale.new(v)
        end
      end
    end
  end
end
