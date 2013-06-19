Capistrano::Configuration.instance(:must_exist).load do

  begin
    require 'rvm/capistrano'

    _cset :rvm_ruby_string, :release_path
  rescue LoadError
    puts "WARNING: RVM is not part of the application"
  end

end
