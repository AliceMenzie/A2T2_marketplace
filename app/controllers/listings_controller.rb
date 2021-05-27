class ListingsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit list]
  before_action :set_listing, only: %i[show]
  before_action :authorize_listing, only: %i[edit update destroy]

  def list
    @my_listings = current_user.listings
  end

  def index
    if user_signed_in?
      @listings = []
      # get all postcodes of current user
      # get all users postcodes which shared with current user

      current_user.addresses.includes(user: { addresses: [] }).pluck(:postcode).uniq.each do |cupc|
        # current_user_post_code = cupc.postcode
        # User.joins(:addresses).where()
        Listing.active.includes(user: { addresses: [] }).each do |listing|
          pc = listing.user.addresses.first().postcode
          @listings << listing if pc == cupc
        end
      end
      @listings
    else
      @listings = Listing.active.sample(6)
    end
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

  # def show
  #   # @listing = Listing.find(params[:id])

  # end
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
      ######## puts in a message
      flash[:alert] = "Sign up to purchase today!"
    end
  end

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
    @listing = Listing.find(params[:id])
  end
end
