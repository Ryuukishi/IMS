module Files
  def self.exist # Check if saved data exists
    ((File.exist?("inventory.yml")) && (File.exist?("id.yml")))
  end

  def self.empty # If saved data exists, check if it's an empty file
    if self.exist
      @id = YAML.load(File.read("id.yml"))
      @inventory = YAML.load(File.read("inventory.yml"))
    end
    (((@id.empty?) || ((@inventory.empty?))))
  end
end
