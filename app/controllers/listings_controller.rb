class ListingsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit]
  before_action :set_listing, only: %i[show]
  before_action :authorize_listing, only: %i[edit update destroy]

  def index
    @listings = Listing.active.sample(6)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    # @listing.status = 1
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def edit; end

  

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

 

  def destroy
    @listing.destroy
    flash[:alert] = 'Deleted Listing'
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :price, :category, :images)
  end

  def authorize_listing
    @listing = current_user.listings.find_by_id(params[:id])
    return if @listing

    flash[:alert] = 'You do not have permissions to access this page'
    redirect_to listings_path
  end



  def set_listing
    @listing = Listing.find(params[:id])
  end
end
