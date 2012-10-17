require "./lib/supervisor/job"
require "./lib/supervisor/server"
require "./lib/supervisor/worker"
require "./lib/supervisor/version"

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