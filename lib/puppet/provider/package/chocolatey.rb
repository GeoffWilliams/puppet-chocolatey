require 'puppet/provider/package'

Puppet::Type.type(:package).provide(:chocolatey, :parent => Puppet::Provider::Package) do

  desc "mock chocolatey package provider"

  has_feature :installable
  has_feature :uninstallable
  has_feature :upgradeable
  has_feature :versionable
  has_feature :install_options
  has_feature :uninstall_options
  has_feature :holdable

  def initialize(value={})
    super(value)
  end

  def print()
    notice("The value is: '${name}'")
  end


  def install
    "installed :)"
  end

  def uninstall
    "uninstalled :)"
  end

  def update
    "updated :)"
  end

  # from puppet-dev mailing list
  # Puppet will call the query method on the instance of the package
  # provider resource when checking if the package is installed already or
  # not.
  # It's a determination for one specific package, the package modeled by
  # the resource the method is called on.
  # Query provides the information for the single package identified by @Resource[:name].
  def query
    self.class.instances.each do |package|
      return package.properties if @resource[:name][/\A\S*/].downcase == package.name.downcase
    end

    return nil
  end

  def self.listcmd
    []
  end

  def self.instances
    []
  end

  def latestcmd
    ['hello']
  end

  def latest
    "latest"
  end

  def hold
    "held :)"
  end

  def unhold
    "unheld :)"
  end
  
end
