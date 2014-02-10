# Halfday

This gem adds some recipes for Capistrano.

*__Warning:__ It is not recommended to use this gem as is since you need your server to be configured in a very specific way. Extract what you need or fork it to make it compliant with your setup.*

## Installation

Add this line to your applicationns `Gemfile`:

```ruby
gem 'halfday', require: false
```

## Usage

Add those lines to your application’s `Capfile`:

```ruby
set :application, 'YOUR APPLICATION NAME'
set :repository, 'YOUR GIT REPOSITORY'

require 'halfday'
```

### Defining your environments

You still need to define every environments in `config/deploy/`.

```ruby
# config/deploy/staging.rb

role :app, 'HOSTNAME', primary: true
role :web, 'HOSTNAME', primary: true
role :db,  'HOSTNAME', primary: true

set :default_tag, '0.2.4' # Branch or Tag
```

## Available recipes

For now, all those recipes will be used on deployment if their Gem is included in your `Gemfile`.

You can manually skip a recipe by setting the `ignored_recipes` config variable:
```RUBY
set :ignored_recipes, [:nginx]
```

### Branch deployment

On deployment, you’ll be ask to specify the `branch` or `tag` you want to deploy. If you hit `Enter`, the `default_tag` will be used. You can also enter `HEAD` to use the branch you’re currently on.

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

If you’re using [RVM](https://rvm.io/) on your server, it’ll automatically use the Ruby version written in your `.ruby-version` file.

### Whenever

If your project includes [Whenever](https://github.com/javan/whenever), the crontab will be updated automatically in a callback.

### Yard

```bash
cap yard:generate        # Generate your doc and make it available
                         # in http://.../doc
```

## Todo

* ~~Add a more flexible way to manage which recipes should be applied.~~
* Add Rails generator for the Capfile.
* Remove dependancy from Rails.
* More recipes, always.

## License

`Halfday` is © 2013 [Mirego](http://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause).  See the [`LICENSE.md`](https://github.com/mirego/active_model_serializers_validator/blob/master/LICENSE.md) file.

## About Mirego

[Mirego](http://mirego.com) is a team of passionate people who believe that work is a place where you can innovate and have fun. We're a team of [talented people](http://life.mirego.com) who imagine and build beautiful Web and mobile applications. We come together to share ideas and [change the world](http://mirego.org).

We also [love open-source software](http://open.mirego.com) and we try to give back to the community as much as we can.
