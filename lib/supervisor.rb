require "./lib/supervisor/job"
require "./lib/supervisor/server"
require "./lib/supervisor/worker"
require "./lib/supervisor/version"
require "./lib/supervisor/application/app"

module Supervisor 
  def self.[](key)
    unless @config
      @config = YAML.load_file("config.yml").symbolize_keys
    end
    @config[key.to_sym]
  end
  
  def self.[]=(key, value)
    @config[key.to_sym] = value
  end

  def self.app_mode?
    return !ENV["RAILS_ENV"].present?
  end

  def self.connected?
    if defined? Supervisor.connection
      return true
    else
      return false
    end
  end

  def self.establish_connection
    if Supervisor[:database]["host"].nil?
      raise "No job database is configured. Please add one in the config.yml file."
    else
      if defined? connection
        p "There is already a DB connection locally...closing"
        Supervisor.connection.disconnect!
        Supervisor.connection.connection.close
        ActiveRecord::Base.clear_active_connections!
        ActiveRecord::Base.clear_reloadable_connections!
      end
      begin
        db = Supervisor[:database]
        connection =  ActiveRecord::Base.establish_connection(:adapter => db["adapter"],:database => db["database"],:host=>db["host"],:port=>db["port"],:username=>db["username"],:password=>db["password"],:encoding => "utf8",:template=>"template0")
        return connection
      rescue
        raise "Could not connect to the job database"
      end
    end
  end

  def self.delayed_job_running_locally?
    local_delayed_jobs = %x{ps aux}.split(/\n/).map{|x| x.split(/\s+/) if x.split(/\s+/).last.match("job")}.compact
    if local_delayed_jobs.empty?
      return false
    else
      return true
    end
  end

  def self.initialize_servers
    if Supervisor[:hosts].first["host"].nil? && !delayed_job_running_locally?
      raise "No job worker machines (host) configured and no workers running locally. Please add host in config.yml"
    elsif Supervisor[:hosts].first["host"].nil? && delayed_job_running_locally?
      Supervisor::Server.new
    else
      Supervisor[:hosts].each do |host|
        Supervisor::Server.new(host["name"],host["host"],host["rails_path"],host["username"],host["password"])
      end
      if delayed_job_running_locally?
        Supervisor::Server.new #init a default local server
      end
    end
    return Supervisor::Server.servers
  end

  def self.start!
    begin
      Supervisor.establish_connection
      Supervisor.initialize_servers
      Supervisor::App.run!
    rescue
      raise "Could not start Supervisor App: #{$!}"
    end
  end

end