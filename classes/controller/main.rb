module Autoloader
  module Controller
    class Main < Ramaze::Controller
      map '/main/'

      def index
        main = Autoloader::Stashe::Main.new
        main.render
      end
    end
  end
end