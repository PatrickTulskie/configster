require "spec_helper"

describe Configster do
  
  subject do
    Configster.load!(File.join($spec_root, 'configurations', 'test_configuration.yml'))
    Configster
  end
  
  it { should respond_to(:config_for) }
  
  it "should be able to load the configuration for a specific class" do
    Configster.config_for(KonfiguredKlass).should_not be_nil
  end
  
  it "should be able to load a directory of yml files" do
    Configster.load!(File.join($spec_root, 'configurations'))
    Configster.config_for('SecondConfiguration').should_not be_nil
  end
  
  it "should not destroy other configurations when loading additional configs" do
    Configster.load!('test_thing' => { 'test' => true })
    Configster.config_for('test_thing').test.should be_true
    Configster.config_for(KonfiguredKlass).user_name.should == 'configster'
  end
  
end