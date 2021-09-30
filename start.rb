require 'tty-prompt'
require 'tty-font'
require_relative './crud.rb'
require_relative './views/prompt.rb'


class Start

    def menu
        Prompt.menu        
    end
end

font = TTY::Font.new(:standard)
puts font.write('IMS')
start = Start.new
start.menu
