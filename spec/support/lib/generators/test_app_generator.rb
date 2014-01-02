require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base

  def configure

    gem 'hydra-head'
    gem 'hydra-editor', path: '../../'
    gem "factory_girl_rails"
    gem 'capybara'

    generate "blacklight --devise"
    generate "hydra:head -f"

    rake "db:migrate"
    rake "db:test:prepare"
    
    gsub_file "app/controllers/application_controller.rb", "layout 'blacklight'", "layout 'application'"

    insert_into_file "config/routes.rb", :after => '.draw do' do
      "\n  mount HydraEditor::Engine => \"/\"\n"
    end
    remove_file "spec/factories/users.rb" # generated by devise
    remove_file "spec/models/user_spec.rb" # generated by devise

  end


end
