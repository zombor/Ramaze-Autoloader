module Autoloader
  module Stashe
    class Main < Mustache
      def name
        "Chris"
      end

      def value
        10_000
      end

      def taxed_value
        value * 0.6
      end

      def in_ca
        true
      end
    end
  end
end