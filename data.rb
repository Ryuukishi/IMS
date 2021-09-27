require "csv"
require "tty-table"
header = ["header1","header2"]
row = [["a1", "a2"], ["b1", "b2"]]
# test = [["header1","header2"]]
# test = header + row
table = TTY::Table.new(header, row)
puts table.render(:ascii)
# p test