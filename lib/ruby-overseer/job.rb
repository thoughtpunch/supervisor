module Overseer
  class Job < ActiveRecord::Base
    self.table_name = "delayed_jobs"
  end
end
