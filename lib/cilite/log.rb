module CiLite
  module Log
    class << self
      def []=(hash, result)
        KVS['logs'] = logs << hash
        KVS[hash] = result
      end

      def [](hash)
        KVS[hash]
      end

      def logs
        KVS['logs'] || []
      end
    end
  end
end
