Capistrano::Configuration.instance(:must_exist).load do

  after 'deploy:create_symlink', 'yard:generate'

  namespace :yard do

    desc "Update the documentation alone before a release`"
    task :generate, :roles => :app do
      # Build the documentation for the application and make it public
      run "mkdir #{current_path}/doc"
      run "cd #{current_path} && #{bundle_cmd} exec yard doc RAILS_ENV=#{stage}"
      run "mv #{current_path}/doc #{current_path}/public/doc"
    end

  end

end
