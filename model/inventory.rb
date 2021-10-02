require 'securerandom'
class Inventory
    
    attr_accessor :name, :price, :quantity
    
    def initialize(name, price, quantity)
        @name = name
        @price = price
        @quantity = quantity
    end

    #generates a 32-character hexidecimal string. This will ensure a unique ID everytime and doesn't require us to keep track of which IDs are already taken such as with numeric IDs.
    def self.id
        SecureRandom.hex
    end

end
