module Enoki
  class CLI < Thor
    no_commands do
      def say_error(message)
        say(message, :red)
      end

      def say_warning(message)
        say(message, :yellow)
      end
    end
  end
end
