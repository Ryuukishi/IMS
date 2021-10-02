require 'tty-prompt'
require_relative '../controller/file.rb'
require_relative '../controller/crud.rb'
require_relative '../views/screen.rb'

module Prompt

    def self.menu
        Screen.title
        prompt = TTY::Prompt.new
        choices = [
        {name: 'Create Inventory List', value: 1},
        {name: 'Update', value: 2},
        {name: 'Delete', value: 3},
        {name: 'Display', value: 4},
        {name: 'Export CSV', value: 5},
        {name: 'Quit', value: 6}
        ]
        
        if Files.exist && ! Files.empty
            Crud.load
        else
            choices[1][:disabled] = "       * (No inventory) *"
            choices[2][:disabled] = "       * (No inventory) *"
            choices[3][:disabled] = "      * (No inventory) *"
            choices[4][:disabled] = "   * (No inventory) *"
        end

        answer = prompt.select('Select', choices, cycle: true)
        case answer
            when 1 # Create
                Screen.title
                Crud.create
                next_choices = ['Add', 'Finish']
                next_answer = prompt.select('Add more?', next_choices)
                until next_answer == 'Finish'
                    Crud.create
                    next_answer = prompt.select('Add more?', next_choices)
                end
                Screen.title
                Crud.save
                self.menu
            when 2 # Update
                Screen.title
                Crud.update
                Crud.save
                self.menu
            when 3 # Delete
                Screen.title
                Crud.delete
                Crud.save
                self.menu
            when 4 # Display
                Screen.title
                Crud.display_table
                answer = prompt.select('',['Back'])
                self.menu
            when 5 # Export
                Screen.title
                Crud.export
                puts "Exported to 'Inventory.csv'"
                sleep(1)
                self.menu
            when 6 # Exit
         end

    end

end