require 'tty-prompt'
require 'tty-font'
require_relative './crud.rb'
require_relative './views/prompt.rb'

class Start
    system("cls") || system("clear")
    font = TTY::Font.new(:standard)
    puts font.write('IMS')
    def menu
        Prompt.menu        
    end
end

start = Start.new
start.menu
