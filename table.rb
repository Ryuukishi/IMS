require "csv"
require "tty-table"

# print table on terminal

header = ["Header1","Header2"]
row = [["a1", "a2"], ["b1", "b2"]]
# table = TTY::Table.new(header, row)
# puts table.render(:ascii, alignment: :center)
table = []
table << header
p table + row
# row = CSV::Row.new(header, row)
# row.headers
# CSV.open("new.csv", "w")

# arr1 = [["Header1","Header2"], ["a1","a2"], ["b1","b2"]]
# header =  arr1[0]#.flatten
# # p header
# CSV.open('file.csv', 'w') do |csv|
#   arr1.each { |ar| csv << ar }
# end

headers = {header1: 'Item', header2: 'Price', header3: 'Quantity'}
array = []
headers.each { |key, value|
    array << value
}

