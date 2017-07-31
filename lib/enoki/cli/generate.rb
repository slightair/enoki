require 'pathname'

module Enoki
  class CLI < Thor
    NAME_PLACEHOLDER = '__name__'

    include Thor::Actions

    desc "generate TEMPLATE FUNCTION_NAME", "generate code files from template"
    def generate(template_name, name)
      unless templates.include? template_name
        say_error "Template not found"
        exit 1
      end

      selected_template_root = Pathname.new(File.expand_path(template_name, template_dir))
      project_root = Pathname.new(project_root_dir)
      file_list = Dir.glob(File.join(selected_template_root, "**/*.tt")).map do |file|
        Pathname.new(file).relative_path_from(selected_template_root)
      end

      file_list.each do |path|
        source_path = path.expand_path(selected_template_root).to_path
        dest_path = path.sub(NAME_PLACEHOLDER, name.capitalize).expand_path(project_root).to_path.chomp(".tt")

        template(source_path, dest_path, context: context_for_template(name))
      end
    end

    no_commands do
      def context_for_template(name)
        binding
      end
    end
  end
end
