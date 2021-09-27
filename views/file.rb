module File

    @file_exist = nil

    def self.exist
        if File.exist?("./Inventory")
            @file_exists = true
        else
            @file_exists = false
        end
    end
end