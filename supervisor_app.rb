require './lib/supervisor.rb'
begin
  Supervisor.start!
rescue
  raise "Could not start Supervisor App: #{$!}"
end
