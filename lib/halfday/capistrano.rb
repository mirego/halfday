require 'halfday/helpers/cset'
require 'halfday/helpers/require_recipe'

Capistrano::Configuration.instance(:must_exist).load do
  require "bundler/capistrano"

  # Load 3rd party recipes
  require_recipe 'dotenv/capistrano'
  require_recipe 'rvm/capistrano'

  load 'deploy' if respond_to?(:namespace)
  load 'deploy/assets'

  [:foreman, :git, :yard, :whenever].each do |mod|
    require "halfday/#{mod}/capistrano"
  end

  # Callbacks
  after 'deploy',             'deploy:cleanup'
  after 'deploy:update_code', 'deploy:migrate'

  # Stages
  _cset :stages,        %w(ci qa staging)
  _cset :default_stage, 'ci'

  # Bundler
  _cset :bundle_without, [:test]

  # Deploy
  _cset :deploy_to,      "/opt/#{application}"
  _cset :scm,            :git
  _cset :keep_releases,  3
  _cset :ssh_options,    {:forward_agent => true}

  # User
  _cset :use_sudo,       false
  _cset :user,           :ubuntu

  # Environment
  #
  # On all our remote server, the environment
  # should be staging.
  _cset :rails_env,      Proc.new { 'staging' }
  _cset :migrate_env,    Proc.new { "RAILS_ENV=#{rails_env}" }

end
