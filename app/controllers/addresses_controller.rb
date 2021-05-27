class AddressesController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit index]
 
  before_action :authorize_address, only: %i[edit update destroy]

#--------------------------------------
# Queries the Adressess model checks if current user via the fk
#--------------------------------------
  def index
    @addresses = current_user.addresses
  end

  def new
    @address = Address.new
  end
#--------------------------------------
# Queries the Adressess model checks if current user via the fk,
# adds to the addresses model 
#--------------------------------------
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
#--------------------------------------
# Queries the Adressess model changes coloumn data based on users input
#--------------------------------------
  def update
    if @address.update(address_params)
      redirect_to @address
    else
      render :edit
    end
  end
#--------------------------------------
# Queries the Adressess via fk to the User model
#--------------------------------------
  def show
    @address = Address.includes(user: { addresses: [] }).find(params[:id])
    flash[:alert] = "Address Added Successfully"
    redirect_to addresses_path
  end
#--------------------------------------
# removes all coloumn data refering to the queried address via the user model as fk  
#--------------------------------------
  def destroy
    @address.destroy
    flash[:alert] = "Deleted Address"
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:street, :number, :postcode, :state, :suburb)
  end

  def authorize_address
    @address = current_user.addresses.find_by_id(params[:id])
    return if @address

    flash[:alert] = "You do not have permissions to access this page"
    redirect_to listings_path
  end

end
