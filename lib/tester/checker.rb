module Tester
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
      `git fetch origin && git reset --hard origin/#{branch}`
    end

    def head
      `git rev-parse origin/#{branch}`.chomp
    end
  end
end
