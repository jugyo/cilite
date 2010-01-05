module Tester
  class Runner
    def self.start(options)
      self.new(options).start
    end

    attr_reader :config, :checker
    attr_accessor :testing, :started

    def initialize(options)
      @config = (KVS['config'] || {}).merge(options)
      @checker = Checker.new(@config[:branch])
    end

    def start
      return if started
      Thread.start do
        loop do
          begin
            test_if_updated
          rescue Exception => e
            puts "#{e.message}\n  #{e.backtrace.join("\n  ")}"
          ensure
            sleep config[:interval]
          end
        end
      end
      self.started = true
    end

    def test_if_updated
      checker.if_updated do |hash|
        begin
          self.testing = true
          test(hash)
        ensure
          self.testing = false
        end
      end
    end

    def test(hash)
      process = TestProcess.new(config[:test_command])
      process.start
      puts "#{hash} => #{process.status}"
      puts process.output
      Log[hash] = process.to_hash.merge(
                    :hash => hash,
                    :created_at => Time.now,
                    :branch => config[:branch]
                  )
    end
  end
end
