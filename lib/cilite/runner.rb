module CiLite
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
      puts "<magenta>start: #{hash}</magenta>".termcolor, config[:test_command]

      build = Build.new(config[:test_command])
      build.start
      Log[hash] = build.to_hash.merge(
                    :hash => hash,
                    :created_at => Time.now,
                    :branch => config[:branch]
                  )

      output_result(hash, build)
    end

    def output_result(hash, build)
      puts build.output
      if build.success?
        puts "<green>[Success!] #{hash}</green>".termcolor
      else
        puts "<red>[Failure!] #{hash}</red>".termcolor
      end
    end
  end
end
