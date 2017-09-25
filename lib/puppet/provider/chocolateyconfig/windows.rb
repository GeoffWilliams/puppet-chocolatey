require 'puppet/type'
require 'pathname'
require 'rexml/document'

Puppet::Type.type(:chocolateyconfig).provide(:windows) do
  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def properties
    if @property_hash.empty?
      @property_hash = query || { :ensure => ( :absent )}
      @property_hash[:ensure] = :absent if @property_hash.empty?
    end
    @property_hash.dup
  end

  def query
    self.class.configs.each do |config|
      return config.properties if @resource[:name][/\A\S*/].downcase == config.name.downcase
    end

    return {}
  end

  def self.get_configs
    []
  end

  def self.configs
    []
  end

  def self.refresh_configs
    @configs = nil
    self.configs
  end

  def self.instances
    []
  end

  def self.prefetch(resources)
    instances.each do |provider|
      if (resource = resources[provider.name])
        resource.provider = provider
      end
    end
  end

  def create
    @property_flush[:ensure] = :present
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def destroy
    @property_flush[:ensure] = :absent
  end

  def validate
    true
  end

  mk_resource_methods

  def flush

    @property_hash.clear
    @property_flush.clear

    self.class.refresh_configs
    @property_hash = query
  end
end
