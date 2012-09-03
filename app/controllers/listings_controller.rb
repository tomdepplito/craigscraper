class ListingsController < ApplicationController
  def index
    @search = Listing.search(params[:q])
    @listings = @search.result
  end
  
  def new
    Listing.get_listings
    redirect_to :back
  end
end
