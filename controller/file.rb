module File_check

    def self.exist
        (File.exist?("./Inventory.csv"))
    end

end