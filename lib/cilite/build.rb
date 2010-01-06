module CiLite
  class Build < Struct.new(:status, :pid)
    attr_reader :command, :status, :pid, :output

    def initialize(command)
      @command = command
    end

    def start
      IO.popen("#{command} 2>&1") do |io|
        @pid = pid
        @output = io.read
      end
      @status = $?.exitstatus.to_i
    rescue Exception => e
    end

    def to_hash
      {:status => status, :output => output}
    end
  end
end
