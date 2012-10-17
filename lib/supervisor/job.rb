require 'active_record'

Supervisor.establish_connection

module Supervisor
  class Job < ActiveRecord::Base
    self.table_name = "delayed_jobs"
  end
end
