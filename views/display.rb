module Display
    def self.table(headers, values)
        table = TTY::Table.new(headers, values)
        puts table.render(:ascii, alignment: [:center])
    end
end