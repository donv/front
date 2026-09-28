# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @site = Site.first
    if @site
      @news_items = NewsItem.order(created_at: :desc).to_a
    else
      redirect_to controller: :sites, action: :new
    end
  end
end
