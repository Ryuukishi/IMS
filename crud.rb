require_relative "./inventory.rb"
require_relative './controller/validate.rb'
require 'tty-prompt'
require 'csv'
require 'yaml'

module Crud

    @headers = ["Name", "Price", "Quantity"]
    @row = []
    @rows = []
    @table = []
    # @row << @name << @price << @quantity
    @id = nil
    @inventory_record = {}
    @id_record = {}

    def self.load
        save_data = YAML.load(File.read("Inventory.yml"))
    end


    def self.create
        prompt = TTY::Prompt.new
        name = prompt.ask('Item name:', required: true)
        if @id_record.include? name
            puts "Item already in inventory!"
            sleep(1)
            self.create()
        else
            @id = Inventory.id
            @id_record[name] = @id
        end
        @row << name
        price = prompt.ask('Price:', required: true) do |q|
            q.validate(/^(?!0\d)\d*(\.\d+)?$/)
            q.messages[:valid?] = "Must be a positive number"   # raise error if price is not a positive integer or float
        end                     
        @row << price
        quantity = prompt.ask('Quantity', required: true)  do |q|
            q.validate(/^(?!0\d)\d*$/)
            q.messages[:valid?] = "Must be a positive number"   # raise error if quantity is not a positive integer
        end
        @row << quantity
        @inventory = Inventory.new(name, price, quantity)
        @inventory.print_item
        @rows << @row
        @row = []
        @inventory_record[@id] = [name, price, quantity]
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
                when 2
                    quantity = prompt.ask('Quantity:', required: true)
                    @inventory_record[@id_record[name]][2] = quantity
            end
        end
    end

    def self.print_table
        @table << @headers
        @inventory_record.each do |key, value|
        values = [value]
        @table << values
        end
        table = TTY::Table.new(@table)
        puts table.render(:ascii, alignment: [:center])
        p @table
    end

end
