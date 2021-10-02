module Screen

	def self.title # Clears the screen and displays the logo
		system("cls") || system("clear")
		font = TTY::Font.new(:standard)
		puts font.write('IMS')
	end
	
	def self.clear # Clears the screen
		system("cls") || system("clear")
	end
end