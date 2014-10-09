require 'active_model'

class Product

	include ActiveModel::Validations

	attr_accessor :name, :imported, :price, :tax
	attr_reader :count
	validates :name, presence: true
	validates :price, numericality: true, presence: true

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