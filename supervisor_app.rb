require 'supervisor'
begin
  Supervisor.start!
rescue
  raise "Could not start Supervisor App: #{$!}"
end
