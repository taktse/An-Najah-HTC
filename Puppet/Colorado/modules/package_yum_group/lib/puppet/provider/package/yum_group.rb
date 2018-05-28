Puppet::Type.type(:package).provide :yum_group, :parent => :rpm, :source => :rpm do
  desc "Support via `yum groupinstall`.

  This is a really simple provider to just allow yum groups to be installed and
  removed"

  commands :cmd => "yum"

  # god only knows...
  # def self.prefetch(resources)
  #   instances.each do |prov|
  #     if resource = resources[prov.name]
  #       resource.provider = prov
  #     end
  #   end
  # end


  def install
    execute([command(:cmd), "-y", "group", "install", @resource[:name]])
  end


  def uninstall
    execute([command(:cmd), "-y", "group", "remove", @resource[:name]])
  end


  def self.instances
    yum_groups = execute([command(:cmd), "group", "list", "installed", "-q"])

    # returns a Puppet::Util::Execution::ProcessOutput which is a kinda magic
    # string-like thing thats not really a string and is also a private API. for
    # safety/sanity - convert into a real string for us to use it...
    yum_groups.to_s.split("\n").reject { |line|
      line =~ /^\s*$/
    }.map { |group|
      {
        :name     => group.strip,
        :ensure   => :present,
        :provider => :yum_group,
      }
    }.collect { |h|
      new(h)
    }
  end

end
