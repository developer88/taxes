class CartController < ApplicationController

	before_filter :initialize_session

	def index			
		if cart_params[:product]
			@product = Product.new(cart_params[:product])
			session[:goods] << @product.to_hash if @product.valid?
		end
		@goods = session[:goods]
	end

	def bill
		@product_group = ProductGroup.new
		session[:goods].each {|g| @product_group.add g }
	end

	private

		def initialize_session
			session[:goods] = [] unless session[:goods]	
		end

		def cart_params
			params.permit(product: [:name, :price, :imported])
		end	

end
