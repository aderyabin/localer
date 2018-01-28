# frozen_string_literal: true

require 'aruba/cucumber'

DUMMY_APP_DIR = "../../spec/dummy_app"
LOCALE_DIR = "#{DUMMY_APP_DIR}/config/locales"
CONFIG_PATH = "#{DUMMY_APP_DIR}/.localer.yml"

After do |_|
  %w[ru en us].each do |locale|
    path = "#{LOCALE_DIR}/#{locale}.yml"
    remove(path) if exist?(path)
  end

  remove(CONFIG_PATH) if exist?(CONFIG_PATH)
end
