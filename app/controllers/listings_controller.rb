class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_listing, only: [:show, :edit, :update, :destroy ]
  
  def index
    @listings = Listing.all
    end

  def new
    @listing = Listing.new
  end

  def edit

  end

  def destroy 
    @listing.destroy
    flash[:alert] = 'deleted listing'
    redirect_to listings_path
  end 



  def update 
    if @listing.update(listing_params)
      redirect_to @listing
    else 
      render :edit
    end
  end 

  def show
    @listing = Listing.find(params[:id])
    end


    def create 
      @listing = current_user.listings.new(listing_params)
      @listing.status = 1
      if @listing.save 
        redirect_to @listing
      else 
        render :new
      end
    end
    
    
    private 

  def listing_params
    params.require(:listing).permit(:name, :description, :price, :category)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  
end


