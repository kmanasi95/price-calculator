#!/usr/bin/ruby -w

class PriceCalculator
    attr_accessor :items

    UNIT_PRICES = {
        'milk' => 3.97,
        'bread' => 2.17,
        'banana' => 0.99,
        'apple' => 0.89
    }

    SALE_PRICES = {
        'milk' => {'quantity' => 2, 'amount' => 5.00},
        'bread' => {'quantity' => 3, 'amount' => 6.00}
    }

    Total = {
    }

    def initialize(items)
        @items = items.split(',')
        @Total = Total
    end

    def calculate

        @items.each do |item|
            if SALE_PRICES.key?(item.strip.downcase) 
                if @Total.key(item)
                    next
                else
                    q, r = @items.count(item.strip).divmod(SALE_PRICES[item.strip.downcase]['quantity'])
                    amount = (q * SALE_PRICES[item.strip.downcase]['amount']) + (r * UNIT_PRICES[item.strip.downcase])
                    @Total[item] = amount
                end
            elsif UNIT_PRICES.key?(item.strip.downcase)
                if @Total.key(item)
                    next
                else
                    amount = @items.count(item.strip) * UNIT_PRICES[item.strip.downcase]
                    @Total[item] = amount
                end
            end
        end

        puts @Total
    end

end

puts 'Please enter all the items purchased separated by a comma: '
items = gets.chomp

obj = PriceCalculator.new(items)
puts obj.calculate