class WelcomeController < ApplicationController
  def index
    @site = Site.find(:first)
    if @site
      @news_items = NewsItem.find(:all, :order => 'created_at DESC')
    else
      redirect_to :controller => 'sites', :action => :new
    end
  end
  
end
