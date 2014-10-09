require 'active_model'

class ProductGroup

	include ActiveModel::Validations

	attr_accessor :list

	def initialize
	    @list = []
	end	

	def add(product)
		p = Product.new(product)
		list << p if p.valid?
		# todo
	end

	def to_hash
		list.map{|p| p.to_hash}
	end

	def total
		list.map{ |p| p.price }.inject{|sum,x| sum + x } + taxes
	end

	def taxes
		0
	end

end