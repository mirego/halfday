Capistrano::Configuration.instance(:must_exist).load do

  after 'deploy:create_symlink', 'nginx:configure'

  namespace :nginx do

    desc 'Add app configuration for Mirego infrastructure'
    task :configure, roles: :app do
      conf_path = "#{deploy_to}/current/config/deploy/nginx/"

      if %w{ci qa staging}.include?(rails_env)
        if File.directory?(conf_path)
          run "cd #{conf_path} && ln -fsn *.conf /etc/nginx/apps.conf.d"
          run "sudo service nginx reload"
        else
          puts "WARNING: No nginx configuration found for this app"
        end
      end
    end
  end

end
