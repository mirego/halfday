Capistrano::Configuration.instance(:must_exist).load do

  after 'deploy:create_symlink', 'nginx:configure'

  namespace :nginx do

    desc 'Add nginx configuration'
    task :configure, roles: :app do
      if %w{ci qa staging}.include?(rails_env)
        conf_path = "/etc/nginx/apps.conf.d/#{application}.conf"

        upload File.expand_path('../templates/app.conf', __FILE__), conf_path

        run "sed -i #{conf_path} -e s/\\\\[APPLICATION\\\\]/#{application}/g"
        run "source #{current_path}/.env && sed -i #{conf_path} -e s/\\\\[PORT\\\\]/$PORT/g"
        run "sudo service nginx reload"
      end
    end
  end

end
