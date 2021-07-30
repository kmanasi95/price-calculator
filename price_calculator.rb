#!/usr/bin/ruby -w

class PriceCalculator
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

    def initialize(items)
        @items = items.split(',').map(&:strip).map(&:capitalize)
        @total_purchases = Hash.new
    end

    def calculate
        @items.each do |item|
            if SALE_PRICES.key?(item) 
                if @total_purchases.key(item)
                    next
                else
                    quotient, remainder = @items.count(item).divmod(SALE_PRICES[item]['quantity'])
                    amount = (quotient * SALE_PRICES[item]['amount']) + (remainder * UNIT_PRICES[item])
                    @total_purchases[item] = {'quantity' => @items.count(item), 'amount' => amount}
                end
            elsif UNIT_PRICES.key?(item)
                if @total_purchases.key(item)
                    next
                else
                    amount = @items.count(item) * UNIT_PRICES[item]
                    @total_purchases[item] = {'quantity' => @items.count(item), 'amount' => amount}
                end
            end
        end
    end

    def display()
        headers = ['Item', 'Quantity', 'Amount']
        puts "\n"
        puts headers.join('       ')
        puts '---------------------------------'
        @total_purchases.each { |k, v| puts "#{k.ljust(13)} #{v['quantity'].to_s.ljust(12)} #{'$' + v['amount'].to_s}" }

        current_price = 0
        actual_price = 0

        @items.each do |item|
            if UNIT_PRICES.key?(item)
                actual_price += UNIT_PRICES[item]
            end
        end

        @total_purchases.each do |k, v|
            current_price += v['amount']
        end

        current_price = current_price.round(2)
        savings = (actual_price - current_price).round(2)

        puts "\n"
        puts "Total price : #{'$' + current_price.to_s}"
        puts "You saved #{'$' + savings.to_s} today."
        puts "\n"
    end

end

puts 'Please enter all the items purchased separated by a comma: '
items = gets.chomp

obj = PriceCalculator.new(items)
obj.calculate
obj.display