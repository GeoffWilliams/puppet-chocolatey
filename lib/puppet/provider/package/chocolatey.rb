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
    # PuppetX::Chocolatey::ChocolateyCommon.set_env_chocolateyinstall
    #  choco_exe = is_compiled_choco?
    #
    # # always unhold on install
    # unhold if choco_exe
    #
    # args = []
    #
    # # also will need to address -sidebyside or -m in the install args to allow
    # # multiple versions to be installed.
    # args << 'install'
    #
    # should = @resource.should(:ensure)
    # case should
    # when true, false, Symbol
    #   args << @resource[:name][/\A\S*/]
    # else
    #   args.clear
    #   if choco_exe
    #     args << 'upgrade'
    #   else
    #     args << 'update'
    #   end
    #
    #   # Add the package version
    #   args << @resource[:name][/\A\S*/] << '--version' << @resource[:ensure]
    # end
    #
    # if choco_exe
    #   args << '-y'
    # end
    #
    # if @resource[:source]
    #   args << '-source' << @resource[:source]
    # end
    #
    # args << @resource[:install_options]
    #
    # if Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon.choco_version) >= Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon::MINIMUM_SUPPORTED_CHOCO_VERSION_EXIT_CODES)
    #   args << '--ignore-package-exit-codes'
    # end
    #
    # chocolatey(*args)

    "installed :)"
  end

  def uninstall
    # PuppetX::Chocolatey::ChocolateyCommon.set_env_chocolateyinstall
    # choco_exe = is_compiled_choco?
    #
    # # always unhold on uninstall
    # unhold if choco_exe
    #
    # args = 'uninstall', @resource[:name][/\A\S*/]
    #
    # if choco_exe
    #   args << '-fy'
    # end
    #
    # choco_version = Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon.choco_version)
    # if !choco_exe || choco_version >= Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon::MINIMUM_SUPPORTED_CHOCO_UNINSTALL_SOURCE)
    #   if @resource[:source]
    #     args << '-source' << @resource[:source]
    #   end
    # end
    #
    # args << @resource[:uninstall_options]
    #
    # if Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon.choco_version) >= Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon::MINIMUM_SUPPORTED_CHOCO_VERSION_EXIT_CODES)
    #   args << '--ignore-package-exit-codes'
    # end
    #
    # chocolatey(*args)

    "uninstalled :)"
  end

  def update
    # PuppetX::Chocolatey::ChocolateyCommon.set_env_chocolateyinstall
    # choco_exe = is_compiled_choco?
    #
    # # always unhold on upgrade
    # unhold if choco_exe
    #
    # if choco_exe
    #   args = 'upgrade', @resource[:name][/\A\S*/], '-y'
    # else
    #   args = 'update', @resource[:name][/\A\S*/]
    # end
    #
    # if @resource[:source]
    #   args << '-source' << @resource[:source]
    # end
    #
    # args << @resource[:install_options]
    #
    # if Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon.choco_version) >= Gem::Version.new(PuppetX::Chocolatey::ChocolateyCommon::MINIMUM_SUPPORTED_CHOCO_VERSION_EXIT_CODES)
    #   args << '--ignore-package-exit-codes'
    # end
    #
    # if self.query
    #   chocolatey(*args)
    # else
    #   self.install
    # end
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
    # choco_exe = is_compiled_choco?
    # if choco_exe
    #   args = 'upgrade', '--noop', @resource[:name][/\A\S*/], '-r'
    # else
    #   args = 'version', @resource[:name][/\A\S*/]
    # end
    #
    # if @resource[:source]
    #   args << '-source' << @resource[:source]
    # end
    #
    # unless choco_exe
    #   args << '| findstr /R "latest" | findstr /V "latestCompare"'
    # end
    #
    # [command(:chocolatey), *args]
  end

  def latest
    #
    # package_ver = ''
    # PuppetX::Chocolatey::ChocolateyCommon.set_env_chocolateyinstall
    # begin
    #   execpipe(latestcmd) do |process|
    #     process.each_line do |line|
    #       line.chomp!
    #       if line.empty?; next; end
    #       if is_compiled_choco?
    #         values = line.split('|')
    #         package_ver = values[2]
    #       else
    #         # Example: ( latest        : 2013.08.19.155043 )
    #         values = line.split(':').collect(&:strip).delete_if(&:empty?)
    #         package_ver = values[1]
    #       end
    #     end
    #   end
    # rescue Puppet::ExecutionFailure
    #   return nil
    # end
    #
    # package_ver
    "latest"
  end

  def hold
    # raise ArgumentError, 'Only choco v0.9.9+ can use ensure => held' unless is_compiled_choco?
    #
    # install
    #
    # args = 'pin', 'add', '-n', @resource[:name][/\A\S*/]
    #
    # chocolatey(*args)
    "held :)"
  end

  def unhold
    # return unless is_compiled_choco?
    #
    # Puppet::Util::Execution.execute([command(:chocolatey), 'pin','remove', '-n', @resource[:name][/\A\S*/]], :failonfail => false)
    "unheld :)"
  end


end
