require 'tty-prompt'
require 'tty-font'
require_relative './crud.rb'
require_relative './views/prompt.rb'
require_relative './views/screen.rb'


class Start
    def menu
        Screen.clear
        Screen.title
        Prompt.menu        
    end
end

start = Start.new
start.menu
