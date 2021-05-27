class ListingsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit list]
  before_action :set_listing, only: %i[show]
  before_action :authorize_listing, only: %i[edit update destroy]




  def list
    @my_listings = current_user.listings
  end

#--------------------------------------
# Queries the postcode column of the addresses model of the current user 
# Queries the postcode column of the addresses model for all users via the User model
# Queries the listing model for sellers (FK) which belong to the addresses model
#--------------------------------------

  def index
    if user_signed_in?
      @listings = []
      current_user.addresses.includes(user: { addresses: [] }).pluck(:postcode).uniq.each do |cupc|
        Listing.with_attached_images.all.active.includes(user: { addresses: [] }).each do |listing|
          pc = listing.user.addresses.first.postcode
          @listings << listing if pc == cupc
        end
      end
      @listings
    else
      @listings = Listing.with_attached_images.all.active.sample(6)
    end
  end

  def new
    @listing = Listing.new
  end

#--------------------------------------
# Queries the Listings Model adds to the model with a column user_id as forgien key
#--------------------------------------

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
#--------------------------------------
# Queries the Listings Model and changes coloumns specified by the user
#--------------------------------------
  def update
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end
#--------------------------------------
# Queries Listing model, checks if listing belongs to current user 
#--------------------------------------
  def show
    if user_signed_in?
      stripe_session = Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        client_reference_id: current_user ? current_user.id : nil,
        customer_email: current_user ? current_user.email : nil,
        line_items: [{
          amount: (@listing.price * 100).to_i,
          name: @listing.name,
          description: @listing.description,
          currency: "aud",
          quantity: 1,
        }],
        payment_intent_data: {
          metadata: {
            listing_id: @listing.id,
            user_id: current_user ? current_user.id : nil,
          },
        },
        success_url: "#{root_url}purchases/success?listingId=#{@listing.id}",
        cancel_url: "#{root_url}listings",
      )
      @session_id = stripe_session.id
    else
      flash[:alert] = "Sign up to purchase today!"
    end
  end

#--------------------------------------
# Queries the Listing Model and removes from model via the pk column
#--------------------------------------

  def destroy
    @listing.destroy
    flash[:alert] = "Deleted Listing"
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :price, :category, :images)
  end

  def authorize_listing
    @listing = current_user.listings.find_by_id(params[:id])
    return if @listing

    flash[:alert] = "You do not have permissions to access this page"
    redirect_to listings_path
  end

  def set_listing
    @listing = Listing.with_attached_images.find(params[:id])
  end
end
