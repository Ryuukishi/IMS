require 'tty-table'
class Inventory
    
    attr_accessor :name, :price, :quantity
    
    def initialize(name, price, quantity)
        @name = name
        @price = price.to_f
        @price = sprintf("%.2f", @price)
        @quantity = quantity
    end

    def print
        table = TTY::Table.new(["Item","Price", "Quantity"], [["#{@name}", "$#{@price}", "#{@quantity}"]])
        puts table.render(:ascii, alignment: [:center])
    end

    def self.id
        rand(1..10000000)
    end

end
