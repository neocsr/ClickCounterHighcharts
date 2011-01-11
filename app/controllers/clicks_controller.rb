class ClicksController < ApplicationController
  def index
    @clicks = Click.all
  end
  
  def new
    @click = Click.new
  end
  
  def create
    @click = Click.new(params[:click])
    if @click.save
      flash[:notice] = "Successfully created click."
      redirect_to clicks_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @click = Click.find(params[:id])
  end
  
  def update
    @click = Click.find(params[:id])
    if @click.update_attributes(params[:click])
      flash[:notice] = "Successfully updated click."
      redirect_to clicks_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @click = Click.find(params[:id])
    @click.destroy
    flash[:notice] = "Successfully destroyed click."
    redirect_to clicks_url
  end
end
