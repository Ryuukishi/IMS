module Screen

	def title
		font = TTY::Font.new(:standard)
		puts font.write('IMS')
	end
	
	def clear
		system("cls") || system("clear")
	end
end