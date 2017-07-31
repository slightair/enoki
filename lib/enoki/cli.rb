require 'enoki'
require 'thor'

module Enoki
  class CLI < Thor
    desc "hello NAME", "say hello to NAME"

    def hello(name)
      puts "Hello #{name}"
    end
  end
end
