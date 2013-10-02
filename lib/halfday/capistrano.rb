require 'halfday/helpers/cset'
require 'halfday/helpers/roles'
require 'halfday/helpers/require_recipe'

Capistrano::Configuration.instance(:must_exist).load do
  # Stages
  # Load 3rd party recipes
  require_recipe "bundler/capistrano"
  require_recipe 'dotenv/capistrano'

  require 'capistrano/ext/multistage'

  load 'deploy' if respond_to?(:namespace)
  load 'deploy/assets'

  # Load recipes
  _cset :ignored_recipes, []

  [:foreman, :git, :yard, :whenever, :rvm, :setup, :nginx].each do |mod|
    require "halfday/#{mod}/capistrano" unless ignored_recipes.include?(mod)
  end

  # Callbacks
  after 'deploy',             'deploy:cleanup'
  after 'deploy:update_code', 'deploy:migrate' if role_available?(:db)

  # Bundler
  _cset :bundle_without, [:test]
  _cset :bundle_cmd,     "bundle"

  # Deploy
  _cset :deploy_to,    "/opt/#{application}"

  _cset :scm,            :git
  _cset :keep_releases,  3
  _cset :ssh_options,    { forward_agent: true }

  # User
  _cset :use_sudo,       false
  _cset :user,           :ubuntu

  # Environment
  #
  # On all our remote server, the environment
  # should be staging.
  _cset :rails_env,      Proc.new { 'staging' }
  _cset :migrate_env,    Proc.new { "RAILS_ENV=#{rails_env}" }

  # Branch
  _cset :branch do
    tag = Capistrano::CLI.ui.ask "Tag or branch to deploy: [#{default_tag}] "
    tag = `git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||'`.chomp if tag == 'HEAD'

    (tag.empty?) ? default_tag : tag
  end

  default_run_options[:pty] = true
end
