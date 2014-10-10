class CartController < ApplicationController

	before_filter :initialize_session

	def index		
		@product = Product.new cart_params.fetch(:product, {})	
		session[:goods] << @product.to_hash if cart_params[:product] &&	@product.valid? 
	end

	def bill
		@product_group = ProductGroup.new
		session[:goods].each {|g| @product_group.add g }
	end

	private

		def initialize_session
			session[:goods] = [] if session[:goods].nil?
		end

		def cart_params
			params.permit(product:[:name, :price, :imported, :type])
		end	

end
