require 'puppet/type'
require 'pathname'
require 'rexml/document'

Puppet::Type.type(:chocolateyfeature).provide(:windows) do


  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def properties
    if @property_hash.empty?
      @property_hash = query
    end
    @property_hash.dup
  end

  def query
    self.class.features.each do |feature|
      return feature.properties if @resource[:name][/\A\S*/].downcase == feature.name.downcase
    end

    return {}
  end

  def self.get_features
    []
  end

  def self.get_feature(element)
    "mockfeature"
  end

  def self.features
    []
  end

  def self.instances
    features
  end

  def self.prefetch(resources)
    instances.each do |provider|
      if (resource = resources[provider.name])
        resource.provider = provider
      end
    end
  end

  def enable
    @property_flush[:ensure] = :enabled
  end

  def exists?
    @property_hash[:ensure] == :enabled
  end

  def disable
    @property_flush[:ensure] = :disabled
  end

  def validate
    true
  end

  mk_resource_methods

  def flush

    @property_hash.clear
    @property_flush.clear

    self.class.features
    @property_hash = query
  end

end
