# Configster

Configster is a tidy little configuration management utility for your application.

You probably haven't heard of it.

## Installation

Add this line to your application's Gemfile:

    gem 'configster'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install configster

## Usage

For most applications, you'll want to load Configster before you start loading the rest of your application.  For example:

    require 'configster'
    Configster.load!(File.join('path', 'to', 'my_config.yml'))
    
You can also pass a raw hash of stuff into `load!` as long as it's in the format of `"ClassName" => { 'variable' => 'whatever' }`

Then, just include Configster in any classes you want:

    class KonfiguredKlass
      include Configster
    end
    
Your class now has access to a `configster` and `raw_configster` function where you can query bits and pieces of your configuration.

## Example

Say you're writing a sweet application that uses [HTTParty](https://github.com/jnunemaker/httparty) to fetch data from Twitter.  You want to share this application with the world, but you don't want to hard code your credentials.  Here's how you might handle that:

First, make yourself a nice little configuration file and save it to `~/my_sweet_app_credentials.yml`:

    MySweetApp:
      username: SweetUsername
      password: SweetPassword123
      
Then, you'll write your application like this:

    require 'configster'
    Configster.load!('File.expand_path(~/my_sweet_app_credentials.yml'))
    
    class MySweetApp

      include Configster
      include HTTParty
      
      def initialize
        @auth = {
          :username => configster.username,
          :password => configster.password
        }
      end
      
      def timeline(which = :friends, options = { })
        options.merge!(:basic_auth => @auth)
        self.class.get("/statuses/#{which}_timeline.json", options)
      end
      
    end
    
You can also access the configuration more directly without the mixin by doing the following:
    
    # Return the config as an instance of OpenStruct
    Configster.config_for('MySweetApp')
    
    # Return the config as a raw hash
    Configster.raw_config_for('MySweetApp')
    
Now you can share your application without hard coding and/or sharing your credentials.

For more examples accessing Configster directly or using it without YAML, check the examples directory in the gem.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write specs for your changes to make sure I don't break your features in the future.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
