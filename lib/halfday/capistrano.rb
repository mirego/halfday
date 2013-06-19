require 'halfday/helpers/cset'
require 'halfday/helpers/require_recipe'

Capistrano::Configuration.instance(:must_exist).load do
  require "bundler/capistrano"

  require_recipe 'whenever/capistrano'
  require_recipe 'dotenv/capistrano'
  require_recipe 'rvm/capistrano'

  _cset(:stages){ %w(ci qa staging) }
  _cset(:default_stage){ 'ci' }

  load 'deploy' if respond_to?(:namespace)
  load 'deploy/assets'

  [:foreman, :git].each do |mod|
    require "halfday/#{mod}/capistrano"
  end
end
