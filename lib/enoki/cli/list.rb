module Enoki
  class CLI < Thor
    desc "list", "list templates"
    def list
      puts templates
    end
  end
end
