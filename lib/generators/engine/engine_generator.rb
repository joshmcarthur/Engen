class EngineGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  desc "Creates a new Rails 3 engine with the name you specify"
  check_class_collision
  
  def create_application_files
    empty_directory file_name
    empty_directory engine_dir('app')
    %w(controllers helpers models views).each do |app_dir|
      empty_directory engine_dir("app/#{app_dir}")
    end
    empty_directory "#{file_name}/config"
    empty_directory "#{file_name}/public"
    template "Gemfile", "#{file_name}/Gemfile"
    template "gitignore.tt", "#{file_name}/.gitignore"
    template "engine.gemspec.tt", "#{file_name}/#{file_name}.gemspec"    
  end
  
  def create_routes
    template "routes.rb", "#{file_name}/config/routes.rb"
  end
  
  def create_lib_files
    directory "lib", "#{file_name}/lib"
  end
  
  def add_to_gemfile
    gem file_name, :path => file_name, :require => file_name
  end
  
  protected
  
  def engine_dir(file_to_join = nil)
    if file_to_join
      File.join(file_name, file_to_join)
    else
      file_name
    end
  end
  
end
