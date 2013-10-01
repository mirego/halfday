Capistrano::Configuration.instance(:must_exist).load do

  after 'deploy', 'foreman:export'
  after 'deploy', 'foreman:restart'

  namespace :foreman do

    desc "Export upstart script"
    task :export, roles: :app do
      # Uploading process template
      run "mkdir -p #{shared_path}/templates"
      upload File.expand_path('../upstart/process.conf.erb', __FILE__), "#{shared_path}/templates/process.conf.erb"

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
      run  "cd #{current_path} && #{bundle_cmd} exec foreman export upstart #{shared_path}/upstart -a #{application} -u #{user} -l #{shared_path}/log/ -t #{shared_path}/templates"
      sudo "mv #{shared_path}/upstart/* /etc/init/"

      # Cleaning up this mess
      run  "rm -rf #{shared_path}/upstart"
      run  "rm -rf #{shared_path}/templates"
    end

    [:start, :stop, :restart].each do |action|
      desc "#{action.to_s.capitalize} application"
      task action, roles: :app do
        sudo "service #{application} #{action}"
      end

      before "foreman:#{action}", 'foreman:export'
    end

  end
end
