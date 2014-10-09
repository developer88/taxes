require 'active_model'

class Product

	include ActiveModel::Validations

	attr_accessor :name, :imported, :price, :tax, :count, :type

	validates :name, presence: true
	validates :price, numericality: true, presence: true
	validates :type, inclusion: { in: %w(book food medical electronics cosmetics),
    message: "%{value} is not a valid type" }

	def initialize(params = {})
	  params.each do |name, value|
        send("#{name}=", value) if value
      end
      @count = 0
	end

	def to_hash
		result = {name: name, price: price, imported: !!imported, tax: tax} 
		result[:count] = count if count > 0
		result
	end

end