module Configster
  
  # =========================================
  # = Class Methods for the Receiving Class =
  # =========================================
  module ClassMethods
    def configster
      @configster ||= Configster.configuration_for(self)
    end
    
    def raw_configster
      Configster.raw_configuration_for(self)
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  # ============================================
  # = Instance Methods for the Receiving Class =
  # ============================================
  def configster
    self.class.configster
  end
  
  def raw_configster
    self.class.raw_configster
  end
  
  # ===========================
  # = Core Configster Methods =
  # ===========================
  def self.load!(configster_config)
    @configster_config = case configster_config
    when Hash
      configster_config
    when String
      YAML.load_file(configster_config)
    end
  end
  
  def self.configuration_for(klass)
    klass_config = @configster_config[klass.to_s]
    klass_config ? OpenStruct.new(klass_config).freeze : nil
  end
  
  def self.raw_configuration_for(klass)
    @configster_config[klass.to_s]
  end
  
end