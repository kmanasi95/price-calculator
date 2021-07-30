#!/usr/bin/ruby -w

class PriceCalculator
    attr_accessor :items

    UNIT_PRICES = {
        'Milk' => 3.97,
        'Bread' => 2.17,
        'Banana' => 0.99,
        'Apple' => 0.89
    }

    SALE_PRICES = {
        'Milk' => {'quantity' => 2, 'amount' => 5.00},
        'Bread' => {'quantity' => 3, 'amount' => 6.00}
    }

    Total = {
    }

    def initialize(items)
        @items = items.split(',').map(&:strip).map(&:capitalize)
    end

    def calculate
        @items.each do |item|
            if SALE_PRICES.key?(item) 
                if Total.key(item)
                    next
                else
                    q, r = @items.count(item).divmod(SALE_PRICES[item]['quantity'])
                    amount = (q * SALE_PRICES[item]['amount']) + (r * UNIT_PRICES[item])
                    Total[item] = {'quantity' => @items.count(item), 'amount' => amount}
                end
            elsif UNIT_PRICES.key?(item)
                if Total.key(item)
                    next
                else
                    amount = @items.count(item) * UNIT_PRICES[item]
                    Total[item] = {'quantity' => @items.count(item), 'amount' => amount}
                end
            end
        end
    end

    def display()
        headers = ['Item', 'Quantity', 'Amount']
        puts "\n"
        puts headers.join('       ')
        puts '---------------------------------'
        Total.each { |k, v| puts "#{k.ljust(13)} #{v['quantity'].to_s.ljust(12)} #{'$' + v['amount'].to_s}" }

        price = 0
        total = 0

        @items.each do |item|
            total += UNIT_PRICES[item]
        end

        Total.each do |k, v|
            price += v['amount']
        end

        savings = (total - price).round(2)

        puts "\n"
        puts "Total price : #{'$' + price.to_s}"
        puts "You saved #{'$' + savings.to_s} today."
        puts "\n"
    end

end

puts 'Please enter all the items purchased separated by a comma: '
items = gets.chomp

obj = PriceCalculator.new(items)
obj.calculate
obj.display