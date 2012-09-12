require 'active_record'
require 'configster'

Configster.load!(
  'my_production_database' => {
    :adapter  => 'mysql2',
    :database => 'configster_production_database',
    :cast     => false
    :encoding => 'utf8'
    :username => 'configster',
    :password => 'configitywiggy',
    :socket   => '/tmp/mysql.sock'
  }
)

# You don't have to load from the mixin - you can just access Configster directly for free form configurations.
my_database_config = Configster.raw_config_for('my_production_database')
my_database_config.symbolize_keys!

# And throw it into ActiveRecord
ActiveRecord::Base.establish_connection(my_database_config)