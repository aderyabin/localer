# frozen_string_literal: true

require "dry-initializer"
require_relative "localer/version"
require_relative "localer/rails"
require_relative "localer/config"
require_relative "localer/data"

module Localer # :nodoc:
  using Localer::Ext::Hash
  # using Localer::Ext::String

  class << self
    def data
      @data ||= load_data
    end

    def config
      @config ||= configure
    end

    def configure(options = {})
      @config = Config.load(options)
    end

    def load_data(source = Localer::Rails.translations)
      @data = Data.new(source)
    end
  end
end
