require "spec_helper"

describe Configster do
  
  subject { Configster }
  it { should respond_to(:configuration_for) }
  
  it "should be able to load the configuration for a specific class" do
    Configster.configuration_for(KonfiguredKlass).should_not be_nil
  end
  
end