module Files

    def self.exist
        (File.exist?("Inventory.csv"))
    end

end