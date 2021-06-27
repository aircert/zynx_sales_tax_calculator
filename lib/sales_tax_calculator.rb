# lib/sales_tax_calculator.rb
class SalesTaxCalculator
	def self.add_to_cart(input)
		if input.empty?
			return 0
		end

		total_price = 0
		total_sale_tax = 0

		items = []

		input.each do |item| 
			item_kind 		= item[0]
			number_of_item 	= item[1]
			sale_price 		= item[2]
			sale_tax 		= item[3]

			amount = number_of_item * sale_price

			if sale_tax != 0
				tax = ((amount * sale_tax) * 20).round.to_f / 20 # round to nearest .05
				
				amount += tax

				total_sale_tax += tax
			end

			items << "#{number_of_item} #{item_kind}: #{amount.truncate(2)}" # had some issues with adding floats in ruby. Seems to be a common problem. This causes one of my test to fail by .01

			total_price += amount
		end

		{
			items: items,
			sales_tax: total_sale_tax.round(2),
			total: total_price.round(2)
		}

	end
end