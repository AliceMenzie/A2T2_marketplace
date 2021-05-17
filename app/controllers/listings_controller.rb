class ListingsController < ApplicationController
  def index
    @listings = Listing.all
    end

  def new
  end

  def edit
  end

  def show
    @listing = Listing.find(params[:id])
    end
end
