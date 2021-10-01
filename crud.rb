require_relative "./inventory.rb"
require_relative './controller/validate.rb'
require_relative './views/display.rb'
require 'tty-prompt'
require 'csv'
require 'yaml'

module Crud

    @headers = ["Name", "Price", "Quantity"]
    @value = []
    @values = []
    @table = []
    @id = nil
    @inventory_record = {}
    @id_record = {}

    def self.load
        @inventory_record = YAML.load(File.read("inventory.yml"))
        @id_record = YAML.load(File.read("id.yml"))
    end

    def self.save
        File.open("inventory.yml", "w") { |file| file.write(@inventory_record.to_yaml) }
        File.open("id.yml", "w") { |file| file.write(@id_record.to_yaml) }
    end

    def self.create
        prompt = TTY::Prompt.new
        name = prompt.ask('Item name:', required: true)
        if @id_record.include? name
            puts "Item already in inventory!"
            sleep(1)
            self.create
        else
            @id = Inventory.id
            @id_record[name] = @id
        end
        @value << name
        price = prompt.ask('Price:', required: true) do |q|
            q.validate(/^(?!0\d)\d*(\.\d+)?$/)
            q.messages[:valid?] = "Must be a positive number"   # raise error if price is not a positive integer or float
        end                     
        @value << price
        quantity = prompt.ask('Quantity', required: true)  do |q|
            q.validate(/^(?!0\d)\d*$/)
            q.messages[:valid?] = "Must be a positive number"   # raise error if quantity is not a positive integer
        end
        @value << quantity
        @inventory = Inventory.new(name, price, quantity)
        Display.table(@headers, [@value])
        @values << @value
        @value = []
        @inventory_record[@id] = [name, price, quantity]
    end

    def self.export
        output = [@headers]
        @inventory_record.each {|key, value|
        output << value
        }
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
                when 3
            end
        end
    end

    def self.delete
        prompt = TTY::Prompt.new
        name = prompt.ask('Item name:', required: true)
        if !@id_record.include? name
            puts "Item not in inventory!"
            sleep(1)
            self.delete
        else
            @inventory_record.delete @id_record[name]
            @id_record.delete name
        end
    end

    def self.display_table
        values = []
        @inventory_record.each { |key, value|
        values << value
        }
        Display.table(@headers, values)
    end
end
