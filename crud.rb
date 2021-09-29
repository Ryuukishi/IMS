require_relative "./inventory.rb"
require 'tty-prompt'
require 'csv'

module Crud

    attr_accessor :headers, :row, :rows, :id, :inventory_hash, :inventory_record

    @headers = ["Name", "Price", "Quantity"]
    @row = []
    @rows = []
    @id = nil
    @inventory_record = {}
    @id_record = {}
    

    def self.create
        prompt = TTY::Prompt.new
        name = prompt.ask('Item name:', required: true)
        @row << name
        price = prompt.ask('Price:', required: true, convert: :float)
        @row << price
        quantity = prompt.ask('Quantity', required: true)
        @row << quantity
        @inventory = Inventory.new(name, price, quantity)
        @inventory.print_item
        @rows << @row
        @row = []
        @id = Inventory.id
        @inventory_record[@id] = [name, price, quantity]
        @id_record[name] = @id
    end

    def self.save
        output = [@headers] + @rows
        CSV.open('Inventory.csv', 'w') do |csv|
            output.each { |arr| csv << arr }
        end
    end

    def self.update
        prompt = TTY::Prompt.new
        name = prompt.ask('Item to change:', required: true)
        if ! @id_record.include? name
            puts "Item not in inventory!"
            sleep(1)
            self.update()
        end
        choices = [
            {name: 'Change Price', value: 1},
            {name: 'Change Quantity', value: 2},
            {name: 'Finish', value: 3}
            ]
        answer = nil
        until answer == 3
            answer = prompt.select('Select', choices, cycle: true)
            case answer
                when 1
                    price = prompt.ask('Price:', required: true)
                    @inventory_record[@id_record[name]][1] = price
                    # @inventory.price = price
                when 2
                    quantity = prompt.ask('Quantity:', required: true)
                    @inventory_record[@id_record[name]][2] = quantity
                    # @inventory.quantity = quantity
            end
        end
    end
end
