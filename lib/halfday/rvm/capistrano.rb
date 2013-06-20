Capistrano::Configuration.instance(:must_exist).load do

  begin
    require 'rvm/capistrano'

    _cset :rvm_ruby_string, :release_path

    # Make sure that the bash_profile is sourced
    # before running bundle command.
    set :bundle_cmd, 'source $HOME/.bash_profile && bundle'
  rescue LoadError
    puts "WARNING: RVM is not part of the application"
  end

end
