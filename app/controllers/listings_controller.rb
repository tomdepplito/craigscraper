class ListingsController < ApplicationController
  def index
    #Listing.get_listings
    @listings = Listing.all
  end
  
  def new
    Listing.get_listings
    redirect_to :back
  end
end
