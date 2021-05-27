class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  before_action :authenticate_user!, only: %i[success index]

#--------------------------------------
# Queries the purchase model via the listing fk
#--------------------------------------
  def success
    @listing = Listing.with_attached_images.all.find(params[:listingId])
  end
#--------------------------------------
# Queries the Adressess via fk to the User model
#--------------------------------------
  def webhook
    payment_intent_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    listing_id = payment.metadata.listing_id
    buyer_id = payment.metadata.user_id

    Purchase.create(user_id: buyer_id, listing_id: listing_id, payment_intent_id: payment_intent_id,
                    receipt_url: payment.charges.data[0].receipt_url)
#--------------------------------------
# Queries the purchases via the user model , queries the listing model updates column status
#--------------------------------------
    listing = Listing.includes(user: { purchases: [] }).find(listing_id)
    listing.update(status: "purchased")
  end
#--------------------------------------
# Queries the user model via the purchases fk 
#--------------------------------------
  def index
    @purchases = current_user.purchases.includes(user: { purchases: [] })
  end
end
