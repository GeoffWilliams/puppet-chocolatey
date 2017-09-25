require 'puppet/type'
require 'pathname'
require 'rexml/document'

Puppet::Type.type(:chocolateysource).provide(:windows) do
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
    self.class.sources.each do |source|
      return source.properties if @resource[:name][/\A\S*/].downcase == source.name.downcase
    end

    return {}
  end

  def self.get_sources
    []
  end

  def self.get_source(element)
    source = {}
    source
  end

  def self.sources
    []
  end

  def self.refresh_sources
    @sources = nil
    self.sources
  end

  def self.instances
    sources
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

  def disable
    @property_flush[:ensure] = :disabled
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

    self.class.refresh_sources
    @property_hash = query
  end
end
