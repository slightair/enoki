module Enoki
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../", File.dirname(__FILE__))
    end

    desc "init", "create settings file"
    def init
      if File.exist?(settings_file)
        exit 0 unless yes?("Settings file already exist. Re-create settings file? (y/N)", :yellow)
      end

      default_template_dir = "./templates"
      default_project_root_dir = "./"
      default_project_file_path = "./YourProject.xcodeproj"

      template_dir = ask("Your template directory?", default: default_template_dir, path: true)
      project_root_dir = ask("Your project root directory?", default: default_project_root_dir, path: true)
      project_file_path = ask("Your project file path?", default: default_project_file_path, path: true)

      config = {
          template_dir: template_dir,
          project_root_dir: project_root_dir,
          project_file_path: project_file_path,
      }
      template('templates/.enoki.yml.tt', settings_file, config)
    end
  end
end
