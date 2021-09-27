require "tty-table"

class DB

    attr_accessor :row, :rows
    headers = ["Name", "Price", "Quantity"]
    def initialize(row = [], rows = [])
        @headers = headers
        @row = row
        @rows = rows
    end

    def gen_header

    def
    
    def parse_csv
        
    end
end

# row = []
# rows = []
# headers << "Header 1"
# headers << "Header 2"
# row << "a1"
# row << "a2"
# rows << row
# row = []
# row << "b1"
# row << "b2"
# rows << row

while row.length < headers.length
    puts headers[row.length]+":"
    row << gets.chomp
end
rows << row
# p headers
p rows