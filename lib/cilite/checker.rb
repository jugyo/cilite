module CiLite
  class Checker
    attr_reader :branch
    attr_accessor :last_hash

    def initialize(branch)
      @branch = branch
    end

    def if_updated(&block)
      update
      hash = head
      if KVS['HEAD'] != hash
        block.call(hash)
        KVS['HEAD'] = self.last_hash = hash
      end
    end

    def update
      unless system("git fetch origin && git reset --hard origin/#{branch}")
        raise "failed to update origin/#{branch}"
      end
    end

    def head
      hash = `git rev-parse origin/#{branch}`.chomp
      raise "failed to get HEAD commit of origin/#{branch}" unless $? == 0
      hash
    end
  end
end
