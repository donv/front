# frozen_string_literal: true

class SitesController < ApplicationController
  def index
    list
    render action: :list
  end

  def list
    @sites = Site.paginate per_page: 10, page: params[:page]
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:notice] = 'Site was successfully created.'
      redirect_to action: 'list'
    else
      render action: 'new'
    end
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(site_params)
      flash[:notice] = 'Site was successfully updated.'
      redirect_to action: 'show', id: @site
    else
      render action: 'edit'
    end
  end

  def destroy
    Site.find(params[:id]).destroy
    redirect_to action: 'list'
  end

  private

  def site_params
    params.require(:site).permit(:title, :welcome_text)
  end
end
