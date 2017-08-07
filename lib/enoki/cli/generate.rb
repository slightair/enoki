require 'pathname'

module Enoki
  class CLI < Thor
    NAME_PLACEHOLDER = "__name__"
    EXT_TEMPLATE = ".tt"
    SOURCE_CODE_EXT_LIST = %w(c m mm swift).map { |ext| ".#{ext}" }

    include Thor::Actions

    desc "generate TEMPLATE FUNCTION_NAME", "generate code files from template"
    method_option :target, aliases: "-t", desc: "Add files to specified target"
    def generate(template_name, name)
      unless templates.include? template_name
        say_error "Template not found"
        exit 1
      end

      selected_template_root = Pathname.new(File.expand_path(template_name, template_dir))
      project_root = Pathname.new(project_root_dir)
      file_list = Dir.glob(selected_template_root.join("**/*#{EXT_TEMPLATE}")).map do |file|
        Pathname.new(file).relative_path_from(selected_template_root)
      end

      file_list.each do |path|
        resolved_path = Pathname.new(path.to_path.gsub(NAME_PLACEHOLDER, name.capitalize).chomp(EXT_TEMPLATE))
        source_path = path.expand_path(selected_template_root).to_path
        dest_path = resolved_path.expand_path(project_root).to_path

        template(source_path, dest_path, context: context_for_template(name))
        add_file_reference(resolved_path, options[:target])
      end

      project.save
    end

    no_commands do
      def context_for_template(name)
        binding
      end

      def add_file_reference(path, target_name)
        path_list = path.to_path.split(File::SEPARATOR)
        group = project.root_object.main_group

        while path_list.size > 1
          dir = path_list.shift
          next_group = group.children.find { |g| g.path == dir } || group.new_group(dir, dir)
          group = next_group
        end

        file = path_list.shift
        file_ref = group.files.find { |f| f.path == file } || group.new_reference(file)

        if SOURCE_CODE_EXT_LIST.include?(path.extname)
          target = project.targets.find { |t| t.name == target_name } || project.targets.first
          if target
            target.source_build_phase.add_file_reference(file_ref, true)
          end
        end
      end
    end
  end
end
