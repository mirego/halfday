# Halfday

This gem adds some recipes for Capistrano.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'halfday'
```

## Usage

Add those lines to your application's `Capfile`:

```ruby
set :application, 'YOUR APPLICATION NAME'
set :repository, 'YOUR GIT REPOSITORY'

require 'halfday'
```

### Defining your environments

You still need to define every environments in `config/deploy/`.

```ruby
# config/deploy/staging.rb

role :app, 'HOSTNAME', :primary => true
role :web, 'HOSTNAME', :primary => true
role :db,  'HOSTNAME', :primary => true

set :default_tag, '0.2.4' # Branch or Tag
```

## Available recipes

For now, all those recipes will be used on deployment if their Gem is included in your `Gemfile`.

### Branch deployment

On deployment, you'll be ask to specify the `branch` or `tag` you want to deploy. If you hit `Enter`, the `default_tag` will be used.

```bash
$ cap staging deploy

  * 2013-06-20 14:02:53 executing `staging'
  * 2013-06-20 14:02:53 executing `deploy'
  * 2013-06-20 14:02:53 executing `deploy:update'
 ** transaction: start
  * 2013-06-20 14:02:53 executing `deploy:update_code'

Tag or branch to deploy: [0.2.4]
```

### Dotenv

[Dotenv](https://github.com/bkeepers/dotenv) is included as well in those recipes, if included in your project, it will automatically *symlink* `/opt/app/shared/.env` into `/opt/app/current` on deployment.

### Foreman

```bash
cap foreman:restart      # Restart your app
cap foreman:start        # Start your app
cap foreman:stop         # Stop your app
cap foreman:export       # Export upstart script to /etc/init/
```

### Git

```bash
cap git:clean            # Remove .git
cap git:init_submodules  # Initialize Git submodule
```

### RVM

If you're using [RVM](https://rvm.io/) on your server, it'll automatically use the Ruby version written in your `.ruby-version` file.

### Whenever

If your project includes [Whenever](https://github.com/javan/whenever), the crontab will be updated automatically in a callback.

### Yard

```bash
cap yard:generate        # Generate your doc and make it available
                         # in http://.../doc
```

## Todo

* Add a more flexible way to manage which recipes should be applied.
* Add Rails generator for the Capfile.
* Remove dependancy from Rails.
* More recipes, always.

## License

`Halfday` is © 2013 [Mirego](http://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause).  See the [`LICENSE.md`](https://github.com/mirego/active_model_serializers_validator/blob/master/LICENSE.md) file.

## About Mirego

Mirego is a team of passionate people who believe that work is a place where you can innovate and have fun.
We proudly built mobile applications for
[iPhone](http://mirego.com/en/iphone-app-development/ "iPhone application development"),
[iPad](http://mirego.com/en/ipad-app-development/ "iPad application development"),
[Android](http://mirego.com/en/android-app-development/ "Android application development"),
[Blackberry](http://mirego.com/en/blackberry-app-development/ "Blackberry application development"),
[Windows Phone](http://mirego.com/en/windows-phone-app-development/ "Windows Phone application development") and
[Windows 8](http://mirego.com/en/windows-8-app-development/ "Windows 8 application development").
