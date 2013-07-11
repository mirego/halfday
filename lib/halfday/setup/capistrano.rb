Capistrano::Configuration.instance(:must_exist).load do

  before 'deploy:setup', 'setup:create_directory'

  namespace :setup do

    desc "Create app directory"
    task :create_directory, roles: :app do
      run "sudo mkdir -p #{deploy_to} && sudo chown ubuntu:ubuntu #{deploy_to}"
    end

  end

end
