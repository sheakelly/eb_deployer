module EbDeployer
  class ResourceStacks
    def initialize(resources, cf_driver, skip_provision=false, tags)
      @resources = resources
      @cf_driver = cf_driver
      @skip_provision = skip_provision
      @tags = tags.to_h
    end

    def provision(stack_name)
      provisioner = CloudFormationProvisioner.new(stack_name, @cf_driver)
      if @resources
        puts "using tags #{tags}"
        provisioner.provision(@resources, @tags) unless @skip_provision
        provisioner.transform_outputs(@resources)
      else
        []
      end
    end
  end
end
