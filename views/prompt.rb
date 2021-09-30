require 'tty-prompt'
require_relative '../controller/file.rb'
require_relative '../crud.rb'

module Prompt

    def self.menu

        prompt = TTY::Prompt.new
        choices = [
        {name: 'Create Inventory List', value: 1},
        {name: 'Update', value: 2},
        {name: 'Delete', value: 3},
        {name: 'Display', value: 4},
        {name: 'Quit', value: 5}
        ]

        if ! File_check.exist
        choices[1][:disabled] = "   * (No inventory) *"
        choices[2][:disabled] = "   * (No inventory) *"
        choices[3][:disabled] = "  * (No inventory) *"
        end

        answer = prompt.select('Select', choices, cycle: true)
        case answer
            when 1 #create new instance of Inventory
                Crud.create
                next_choices = ['Add', 'Finish']
                next_answer = nil
                next_answer = prompt.select('Add more?', next_choices)
                until next_answer == 'Finish'
                    Crud.create
                    next_answer = prompt.select('Add more?', next_choices)
                end
                #clears the screen
                system("cls") || system("clear")
                Crud.save
                self.menu
            when 2
                Crud.update
                self.menu
            when 3
                #Delete
            when 4
                #Display
            when 5    
                #Exits
         end

    end

end