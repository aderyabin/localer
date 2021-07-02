# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'
require 'localer'

module Localer
  # Defines a Rake task for running Localer.
  # The simplest use of it goes something like:
  #
  #   Localer::Rakeask.new
  # This will define a task named <tt>localer</tt> described as 'Run Localer'.
  class RakeTask < Rake::TaskLib
    def initialize(name = :localer, *args) # rubocop:disable Lint/MissingSuper
      @name = name
      desc 'Run Localer'
      task(name, *args) do |_, _task_args|
        sh('localer check') do |ok, res|
          exit res.exitstatus unless ok
        end
      end
    end
  end
end
