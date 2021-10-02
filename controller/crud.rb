require_relative "../model/inventory.rb"
require_relative '../views/display.rb'
require_relative '../views/prompt.rb'
require_relative '../views/screen.rb'
require 'tty-table'
require 'tty-prompt'
require 'csv'
require 'yaml'

module Crud
  @headers = ["Name", "Price", "Quantity"]
  @value = []
  @values = []
  @id = nil
  @inventory_record = {}
  @id_record = {}

  def self.load # Load saved data (if it exists)
    @inventory_record = YAML.load(File.read("inventory.yml"))
    @id_record = YAML.load(File.read("id.yml"))
  end

  def self.save # saves inventory data to YAML file.
    File.open("inventory.yml", "w") { |file| file.write(@inventory_record.to_yaml) }
    File.open("id.yml", "w") { |file| file.write(@id_record.to_yaml) }
  end

  def self.create # Creates a new Inventory instance and saves the details.
    prompt = TTY::Prompt.new
    name = prompt.ask('Item name:', required: true) do |q|
      q.modify :strip, :chomp
    end
    if @id_record.include? name # If item already exists, start again from the beginning
      prompt.warn("Item already in inventory!")
      sleep(1)
      self.create
    else # Else, prompt user for information and saves it
      @id = Inventory.id
      @id_record[name] = @id
      @value << name
      price = prompt.ask('Price:', required: true, convert: :float) do |q|
        q.modify :strip, :chomp
        q.validate(/^(?!0\d)\d*(\.\d+)?$/)
        q.messages[:valid?] = "Must be a positive number"   # raise error if price is not a positive integer or float
      end
      @value << price
      quantity = prompt.ask('Quantity', required: true, convert: :integer) do |q|
        q.modify :strip, :chomp
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
  end

  def self.export # Exports data to .CSV file.
    output = [@headers]
    @inventory_record.each { |key, value|
      output << value
    }
    CSV.open('Inventory.csv', 'w') do |csv|
      output.each { |arr| csv << arr }
    end
  end

  def self.update # Updates the price and quantity of an item.
    self.display_table
    prompt = TTY::Prompt.new
    name = prompt.ask('Item to change:', required: true) do |q|
      q.modify :strip, :chomp
    end
    if !@id_record.include? name # Returns error if item not in inventory
      prompt.warn("Item already in inventory!")
      sleep(1)
      self.update()
    end
    choices = [
      { name: 'Change Price', value: 1 },
      { name: 'Change Quantity', value: 2 },
      { name: 'Finish', value: 3 }
    ]
    answer = nil
    until answer == 3 # Loops until user selects 'Finish' from the menu and goes back to the main menu.
      answer = prompt.select('Select', choices, cycle: true)
      case answer
      when 1
        price = prompt.ask('Price:', required: true, convert: :float) do |q|
          q.modify :strip, :chomp
        end
        @inventory_record[@id_record[name]][1] = price
        Screen.title
        self.display_table
      when 2
        quantity = prompt.ask('Quantity:', required: true, convert: :integer) do |q|
          q.modify :strip, :chomp
        end
        @inventory_record[@id_record[name]][2] = quantity
        Screen.title
        self.display_table
      when 3
        Prompt.menu
      end
    end
  end

  def self.delete # Deletes an item from the inventory
    Screen.title
    self.display_table
    prompt = TTY::Prompt.new
    name = prompt.ask('Item name:', required: true) do |q|
      q.modify :strip, :chomp
    end
    if !@id_record.include? name
      Screen.title
      self.display_table
      prompt.warn("Item not in inventory!")
      sleep(1)
      self.delete
    else
      @inventory_record.delete @id_record[name]
      @id_record.delete name
    end
  end

  def self.display_table # Displays a table with all the items currently stored in the inventory.
    values = []
    @inventory_record.each { |key, value|
      values << value
    }
    Display.table(@headers, values)
  end
end
