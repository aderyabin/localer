# frozen_string_literal: true

require 'yaml'

module Localer
  # Loads and parse Localer config file `.localer.yml`
  class Config < Service
    option :exclude, default: -> { [] }
    def call
      return unless File.exist?(filename)
      yaml = YAML.load_file(filename)
      @exclude = yaml["Exclude"] if yaml&.key?("Exclude")
      self
    end

    private

    def filename
      File.expand_path(".localer.yml", Dir.pwd)
    end
  end
end
