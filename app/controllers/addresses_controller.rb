class AddressesController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit index]
  before_action :set_address, only: %i[show]
  before_action :authorize_address, only: %i[edit update destroy]

  def index
    # @postcode = Address.find(params[:postcode])
    @addresses = current_user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to @address
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to @address
    else
      render :edit
    end
  end

  def show
    @address = Address.find(params[:id])
  end

  def destroy
    @address.destroy
    flash[:alert] = "Deleted Address"
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:street, :number, :postcode, :state)
  end

  def authorize_address
    @address = current_user.addresses.find_by_id(params[:id])
    return if @address

    flash[:alert] = "You do not have permissions to access this page"
    redirect_to listings_path
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
