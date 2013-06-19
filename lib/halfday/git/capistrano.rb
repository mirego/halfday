Capistrano::Configuration.instance(:must_exist).load do

  before 'bundle:install', 'git:init_submodules'
  after  'deploy',         'git:clean'

  namespace :git do

    desc "Update git submodules"
    task :init_submodules, :roles => :app do
      run "cd #{release_path} && git submodule init --quiet"
      run "cd #{release_path} && git submodule update --quiet"
    end

    desc "Remove git crumbles"
    task :clean, :roles => :app do
      run "rm -fr `find #{deploy_to}/releases -iname \".git*\"`"
    end

  end

end
