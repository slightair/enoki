module Enoki
  class CLI < Thor
    no_commands do
      def puts_error(message)
        puts_colored_message(message, Thor::Shell::Color::RED)
      end
      
      def puts_warning(message)
        puts_colored_message(message, Thor::Shell::Color::YELLOW)
      end
      
      def puts_colored_message(message, color)
        puts Thor::Shell::Color.new.set_color(message, color)
      end
    end
  end
end
