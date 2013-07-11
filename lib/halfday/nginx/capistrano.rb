Capistrano::Configuration.instance(:must_exist).load do

  after 'deploy:create_symlink', 'nginx:configure'

  namespace :nginx do

    desc 'Add app configuration for Mirego infrastructure'
    task :configure, roles: :app do
      if %w{ci qa staging}.include?(rails_env)
        conf = File.open(File.expand_path('../templates/app.conf', __FILE__)).read

        run "echo \"#{conf}\" > /etc/nginx/apps.conf.d/#{application}.conf"
        run "cd #{conf_path} && ln -fsn *.conf /etc/nginx/apps.conf.d/"
        run "sudo service nginx reload"
      end
    end
  end

end
