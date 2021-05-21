class PurchasesController < ApplicationController
    def success
        @listing = Listing.find(params[:listingId])
    end    
end
