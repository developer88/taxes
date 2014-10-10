require 'active_model'

class ProductGroup

	include ActiveModel::Validations

	attr_accessor :list

	def initialize
	    @list = []
	end	

	# Merge similar product by incrementing it's count parameter
	def add(product)
		product = Product.new(product)
		return unless product.valid?
		if existed = list.select{|p| p.name == product.name && p.type == product.type && p.price == product.price && p.imported == product.imported }.first
			existed.count += 1 
		else
			list << product 
		end
	end

	def to_hash
		list.map{|p| p.to_hash}
	end

	# Calculate total price
	def total
		(list.map{ |p| p.total }.inject{|sum,x| sum + x }.to_f + taxes).round(2)
	end

	# Calculate total taxes
	def taxes
		(list.map{ |p| p.tax }.inject{|sum,x| sum + x }.to_f).round(2)
	end

end