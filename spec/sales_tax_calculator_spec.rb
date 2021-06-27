require "sales_tax_calculator"

describe SalesTaxCalculator do
	describe ".add_to_cart" do
	    context "given an empty cart" do
	      it "returns zero" do
	        expect(SalesTaxCalculator.add_to_cart([])).to eq(0)
	      end
	    end

	    context "given an item is added to cart" do
	      it "returns sales tax and sale total" do
	        result = SalesTaxCalculator.add_to_cart([
	        	["book", 1, 12.49, 0] # [item_kind, num_of_item, price_of_each, sales_tax]
	        ])
	        expect(result[:items].count).to eq(1)
	        expect(result[:items][0]).to eq("1 book: 12.49")
	        expect(result[:sales_tax]).to eq(0)
	        expect(result[:total]).to eq(12.49)
	      end
	    end

	    context "given multiple items are added to cart" do
	      it "returns sales tax and sale total" do
	        result = SalesTaxCalculator.add_to_cart([
	        	["book", 1, 12.49, 0], # [item_kind, num_of_item, price_of_each, sales_tax]
	        	["music cd", 1, 14.99, 0.10],
	        	["chocolate bar", 1, 0.85, 0]
	        ])

	        expect(result[:items].count).to eq(3)
	        expect(result[:items][0]).to eq("1 book: 12.49")
	        expect(result[:items][1]).to eq("1 music cd: 16.49")
	        expect(result[:items][2]).to eq("1 chocolate bar: 0.85")
	        expect(result[:sales_tax]).to eq(1.50)
	        expect(result[:total]).to eq(29.83)
	      end
	    end

	    context "given multiple imported items are added to cart" do
	      it "returns sales tax and sale total" do
	        result = SalesTaxCalculator.add_to_cart([
	        	["imported box of chocolate", 1, 10.00, 0.05], # food has no sales tax but is imported
	        	["imported bottle of perfume", 1, 47.50, 0.15]
	        ])

	        expect(result[:items].count).to eq(2)
	        expect(result[:items][0]).to eq("1 imported box of chocolate: 10.5") # the 10.50 is truncating even when passed directly back
	        expect(result[:items][1]).to eq("1 imported bottle of perfume: 54.65")
	        expect(result[:sales_tax]).to eq(7.65)
	        expect(result[:total]).to eq(65.15) # this test fails and gives me 8.75. I am not sure what I am missing
	      end
	    end

	    context "given a mix of imported items and non-imported items are added to cart" do
	      it "returns sales tax and sale total" do
	        result = SalesTaxCalculator.add_to_cart([
	        	["imported bottle of perfume", 1, 27.99, 0.15],
	        	["bottle of perfume", 1, 18.99, 0.10],
	        	["packet of headache pills", 1, 9.75, 0],
	        	["imported box of chocolate", 1, 11.25, 0.05]
	        ])

	        expect(result[:items].count).to eq(4)
	        expect(result[:items][0]).to eq("1 imported bottle of perfume: 32.19")
	        expect(result[:items][1]).to eq("1 bottle of perfume: 20.89")
	        expect(result[:items][2]).to eq("1 packet of headache pills: 9.75")
	        expect(result[:items][3]).to eq("1 imported box of chocolate: 11.85")
	        expect(result[:sales_tax]).to eq(6.70)
	        expect(result[:total]).to eq(74.68)
	      end
	    end

	end
end
