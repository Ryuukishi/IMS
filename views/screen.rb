module Screen

	def self.title
		system("cls") || system("clear")
		font = TTY::Font.new(:standard)
		puts font.write('IMS')
	end
	
	def self.clear
		system("cls") || system("clear")
	end
end