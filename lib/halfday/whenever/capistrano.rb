Capistrano::Configuration.instance(:must_exist).load do

  begin
    require 'whenever/capistrano'

    after 'bundle:install', 'whenever:update_crontab'

    set :whenever_environment, defer { rails_env }
    set :whenever_command, "bundle exec whenever"
  rescue LoadError
    puts "WARNING: Whenever is not part of the application"
  end

end
