require 'tty-prompt'
require 'tty-font'
require_relative './crud.rb'

class Start

    attr_reader :file_exist

    def initialize
        self.check_file_exist
    end

    def check_file_exist
        if File.exist?("./save.csv")
            @file_exist = true
        else
            @file_exist = false
        end
    end

    def menu
        prompt = TTY::Prompt.new
        choices = [
            {name: 'Create Inventory List', value: 1},
            {name: 'Update', value: 2},
            {name: 'Delete', value: 3},
            {name: 'Display', value: 4},
            {name: 'Quit', value: 5}
            ]
        if !@file_exist
            choices[1][:disabled] = "   * (No inventory) *"
            choices[2][:disabled] = "   * (No inventory) *"
            choices[3][:disabled] = "  * (No inventory) *"
        end
        answer = prompt.select('Select', choices, cycle: true)
        case answer
            when 1
                Crud.create
                next_choices = ['Add', 'Finish']
                next_answer = nil
                next_answer = prompt.select('Add more?', next_choices)
                until next_answer == 'Finish'
                    Crud.create
                    next_answer = prompt.select('Add more?', next_choices)
                end
                Crud.save
                @file_exist = true    
                self.menu
            when 2
                Crud.update
                self.menu
            when 3
                if @file_exists
                    puts "File exists"
                else
                    puts "File doesn't exist"
                    self.menu
                end
            when 4
                
            when 5                
        end
    end
end

font = TTY::Font.new(:standard)
puts font.write('IMS')
start = Start.new
start.menu
