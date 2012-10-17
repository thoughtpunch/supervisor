require './lib/delayed_job_monitor.rb'
begin
  Supervisor.start!
rescue
  raise "Could not start Supervisor App: #{$!}"
end
