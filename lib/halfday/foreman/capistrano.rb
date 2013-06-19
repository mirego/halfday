Capistrano::Configuration.instance(:must_exist).load do

  after 'deploy', 'foreman:export'
  after 'deploy', 'foreman:restart'

  namespace :foreman do

    desc "Export upstart script"
    task :export, roles: :app do
      # I couldn't simply use `sudo bundle exec` since
      # there was an issue using RVM. It was raising
      #
      # no such file to load -- rubygems
      #
      # If you have an idea on how to fix this. Pull
      # request are more than welcomed :)
      #
      # The fix was to write the upstart script into
      # a non-restricted folder and move it right after.
      run  "cd #{current_path} && bundle exec foreman export upstart -a #{application} -u #{user} -l #{shared_path}/log/ -t #{current_path}/config/upstart/templates #{shared_path}/upstart"
      sudo "mv #{shared_path}/upstart/* /etc/init/"
      run  "rm -rf #{shared_path}/upstart"
    end

    [:start, :stop, :restart].each do |action|
      desc "#{action.to_s.capitalize} application"
      task action, roles: :app do
        sudo "service #{application} #{action}"
      end
    end

  end
end
