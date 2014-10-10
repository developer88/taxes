require 'active_model'

class Product

	include ActiveModel::Validations

	attr_accessor :name, :imported, :price, :count, :type

	validates :name, presence: true
	validates :price, numericality: true, presence: true
	validates :type, inclusion: { in: %w(book food medicine electronics cosmetics),
    message: "%{value} is not a valid type" }

    # Rates for taxes
    IMPORTED_RATE = 0.05
    BASIC_RATE = 0.1
    ROUND_TO = 0.05

	def initialize(params = {})
	  @count = 1
	  params = {} unless params
	  params.each do |name, value|
        send("#{name}=", value) if value && respond_to?("#{name}=")
      end      
	end

	# Convert product to hash
	def to_hash
		{"name" => name, "price" => price.to_f.round(2), "imported" => !!imported, "tax" => tax, "count" => count, "type" => type} 
	end

	# Genetate tax
	def tax
		tax_amount = 0
		tax_amount += price.to_f * BASIC_RATE if %w(electronics cosmetics).include?(type) # basic tax
		tax_amount += price.to_f * IMPORTED_RATE if !!imported # imported tax	
		((tax_amount / ROUND_TO).ceil*ROUND_TO).round(2) # round up
	end

	# Price + tax
	def total
		(price.to_f * count)
	end

end