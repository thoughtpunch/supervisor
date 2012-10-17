require "supervisor/job"
require "supervisor/server"
require "supervisor/worker"
require "supervisor/version"
require "supervisor/application/app"

module Supervisor

  def self.app_mode?
    return !ENV["RAILS_ENV"].present?
  end

end

#Required to use Delayed::Job subclasses outside Rails app.
if Supervisor.app_mode?
  class Rails
    def self.root
      return Pathname.new(Dir.pwd)
    end

    def self.logger
      return nil
    end
  end
end