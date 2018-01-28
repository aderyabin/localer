# frozen_string_literal: true

require "rails"

class DummyApp < Rails::Application
  config.eager_load = false
end
