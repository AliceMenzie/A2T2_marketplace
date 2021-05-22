class AddressesController < ApplicationController

    def index
        # @postcode = Address.find(params[:postcode])
        @address = Address.all
    end 

    # def create
    #     @address = current_user.addresses(params[:addresses])
    # end 
end
