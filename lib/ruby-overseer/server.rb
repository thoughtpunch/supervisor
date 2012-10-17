module Overseer
  class Server
    attr_accessor :name,:host,:rails_path,:connection,:servers
    @@instance_collector = []
    def initialize(name="default",host="localhost",rails_path=nil,username=nil,password=nil)
      unless host == "localhost"
        p host
        @connection = Net::SSH.start(host,username,:password=>password)
        @username = username
      else
        @connection = nil
      end
      @rails_path = rails_path
      @name = name
      @host = host
      @@instance_collector << self
      @servers = @@instance_collector
    end

    def delayed_job_workers
      @worker_list = []
      if self.connection
        workers = connection.exec!("ps aux").split(/\n/).map{|x| x.split(/\s+/) if x.split(/\s+/).last.match("job")}.compact
      else
        workers = %x{ps aux}.split(/\n/).map{|x| x.split(/\s+/) if x.split(/\s+/).last.match("job")}.compact
      end
      if workers.any?
        workers.each do |wkr|
          @worker_list << Hashie::Mash.new({:host=>host,:name=>wkr.last,:pid=>wkr[1],:cpu=>wkr[2],:mem=>wkr[3],:started=>wkr[8],:run_time=>wkr[9]})
        end
        return @worker_list
      else
        return nil
      end
    end
    
  end
end
