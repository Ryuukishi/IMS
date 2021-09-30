module Validate

    def self.number(num)
        ((num.is_a? Integer) || (num.is_a? Float)) && !(num < 0)
    end

end