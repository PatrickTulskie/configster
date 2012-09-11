# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.

require 'rubygems'
require 'rspec'
require 'configster'

$spec_root = File.dirname(__FILE__)

RSpec.configure do |config|
  old_verbose, $VERBOSE = $VERBOSE, nil
  
  def puts(s)
    file = File.basename(caller.first)
    super("puts() from #{file}: #{s}")
  end
  
  def print(s)
    file = File.basename(caller.first)
    super("print() from #{file}: #{s}")
  end

  def p(s)
    file = File.basename(caller.first)
    super("p() from #{file}: #{s}")
  end
end

Configster.load_configster!(File.join($spec_root, 'configurations', 'test_configuration.yml'))

class KonfiguredKlass
  include Configster
end

class AnotherKlass
  include Configster
end
