module Enoki
  class CLI < Thor
    desc "show", "show settings"
    def show
      [:template_dir, :project_root_dir, :project_file_path].each do |e|
        puts("#{e}: #{send(e)}")
      end
    end
  end
end
