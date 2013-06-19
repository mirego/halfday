require 'halfday/helpers/cset'

Capistrano::Configuration.instance(:must_exist).load do
  _cset(:stages){ %w(ci qa staging) }
  _cset(:default_stage){ 'ci' }

  load 'deploy' if respond_to?(:namespace)
  load 'deploy/assets'

  [:foreman, :git].each do |mod|
    require_relative "#{mod}/capistrano"
  end
end
