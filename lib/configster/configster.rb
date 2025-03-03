module Configster
  
  # =========================================
  # = Class Methods for the Receiving Class =
  # =========================================
  module ClassMethods
    def configster
      @configster ||= Configster.config_for(self)
    end
    
    def raw_configster
      Configster.raw_config_for(self)
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
    @configster_config ||= { }
    case configster_config
    when Hash
      @configster_config.merge!(configster_config)
    when String
      if File.directory?(configster_config)
        Dir.glob(File.join(configster_config, "*.yml")).each do |file|
          @configster_config.merge!(YAML.load_file(file))
        end
      elsif File.exist?(configster_config)
        @configster_config.merge!(YAML.load_file(configster_config))
      else
        raise "Unable to locate #{configster_config}"
      end
    end
  end
  
  def self.config_for(klass)
    klass_config = @configster_config[klass.to_s]
    klass_config ? OpenStruct.new(klass_config).freeze : nil
  end
  
  def self.raw_config_for(klass)
    @configster_config[klass.to_s]
  end
  
end