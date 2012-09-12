require 'configster'

# Do this in an initializer somewhere...
Configster.load!(
  'MySweetApp' => {
    'username' => 'SweetUsername',
    'password' => 'SweetPassword123'
  }
)
    
class MySweetApp

  include Configster
  include HTTParty
  # Configure your class here and then you're all set
  basic_auth configster.username, configster.password
      
  def timeline(which = :friends, options = { })
    self.class.get("/statuses/#{which}_timeline.json", options)
  end
      
end