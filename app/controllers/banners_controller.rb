class BannersController < ApplicationController
  def index
    @banners = Banner.all
  end
  
  def show
    @banner = Banner.find(params[:id])
  end
  
  def new
    @banner = Banner.new
  end
  
  def create
    @banner = Banner.new(params[:banner])
    if @banner.save
      flash[:notice] = "Successfully created banner."
      redirect_to @banner
    else
      render :action => 'new'
    end
  end
  
  def edit
    @banner = Banner.find(params[:id])
  end
  
  def update
    @banner = Banner.find(params[:id])
    if @banner.update_attributes(params[:banner])
      flash[:notice] = "Successfully updated banner."
      redirect_to @banner
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy
    flash[:notice] = "Successfully destroyed banner."
    redirect_to banners_url
  end
end
