require "ruby-overseer/version"
require "ruby-overseer/job"
require "ruby-overseer/server"
require "ruby-overseer/worker"

module Overseer

  def self.app_mode?
    return !ENV["RAILS_ENV"].present?
  end

end

#Required to use Delayed::Job subclasses outside Rails app.
if Overseer.app_mode?
  class Rails
    def self.root
      return Pathname.new(Dir.pwd)
    end

    def self.logger
      return nil
    end
  end
end