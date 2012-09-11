require "spec_helper"

describe KonfiguredKlass do
  
  before(:all) do
    @test_klass = KonfiguredKlass.new
  end
  
  subject { @test_klass }
  it { should respond_to(:configster) }
  
  it "should be able to fetch attributes from the configuration" do
    @test_klass.configster.should respond_to(:user_name)
    @test_klass.configster.should respond_to(:password)
    @test_klass.configster.should respond_to(:tag_line)
  end
  
  it "should be frozen" do
    @test_klass.configster.should be_frozen
  end
  
  it "should not pollute other configurations" do
    another_klass = AnotherKlass.new
    @test_klass.configster.user_name.should_not == another_klass.configster.user_name
  end
  
  it "should be able to load a raw configuration" do
    @test_klass.raw_configster.should be_a(Hash)
  end
  
end