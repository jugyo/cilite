module CiLite
  class Runner
    def self.start(options)
      self.new(options).start
    end

    attr_reader :branch, :command, :interval
    attr_accessor :started

    def initialize(options)
      options = (YKK['config'] || {}).merge(options)
      @branch = options[:branch]
      @command = options[:command]
      @interval = options[:interval]
    end

    def start
      return if started
      Thread.start do
        loop do
          begin
            test_if_updated
          rescue Exception => e
            puts "<red>#{TermColor.escape(e.to_s)}</red>".termcolor
          ensure
            sleep interval
          end
        end
      end
      self.started = true
    end

    def test_if_updated
      hash = git_update
      unless YKK.key?(hash)
        test(hash)
      end
    end

    def git_update
      if system("git fetch origin && git reset --hard origin/#{branch}")
        hash = `git rev-parse origin/#{branch}`.chomp
        raise "failed to get HEAD commit of origin/#{branch}" unless $? == 0
        hash
      else
        raise "failed to update origin/#{branch}"
      end
    end

    def test(hash)
      puts "start: #{hash}", command

      build = Build.new(command)
      build.start
      Log[hash] = build.to_hash.merge(
                    :hash => hash,
                    :created_at => Time.now,
                    :branch => branch
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
