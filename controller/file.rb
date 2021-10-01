module Files


    def self.exist
        ((File.exist?("inventory.yml")) && (File.exist?("id.yml")))
    end

    def self.empty
        id = YAML.load(File.read("id.yml"))
        inventory = YAML.load(File.read("inventory.yml"))
        (((id.empty?) || ((inventory.empty?))))
    end

end