module CiLite
  module Log
    class << self
      def []=(hash, result)
        YKK['logs'] = logs << hash
        YKK[hash] = result
      end

      def [](hash)
        YKK[hash]
      end

      def logs
        YKK['logs'] || []
      end
    end
  end
end
