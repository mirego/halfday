Capistrano::Configuration.instance(:must_exist).load do

  begin
    require 'whenever/capistrano'

    before 'whenever:update_crontab', 'bundle:install'

    _cset :whenever_environment, defer { stage }
    _cset :whenever_command, "bundle exec whenever"
  rescue LoadError
    puts "WARNING: Whenever is not part of the application"
  end

end
