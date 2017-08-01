require 'thor'

require 'enoki/cli/shell'
require 'enoki/cli/common'
require 'enoki/cli/init'
require 'enoki/cli/show'
require 'enoki/cli/list'
require 'enoki/cli/generate'

module Enoki
  class CLI < Thor
    desc "version", "print enoki version"
    def version
      puts Enoki::VERSION
    end
    map %w(-v --version) => :version
  end
end
