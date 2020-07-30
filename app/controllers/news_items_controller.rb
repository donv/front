# frozen_string_literal: true

class NewsItemsController < ApplicationController
  def index
    list
    render action: :list
  end

  def list
    @news_items = NewsItem.paginate per_page: 10, page: params[:page]
  end

  def show
    @news_item = NewsItem.find(params[:id])
  end

  def new
    @news_item = NewsItem.new
  end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      flash[:notice] = 'NewsItem was successfully created.'
      redirect_to controller: :welcome, action: :index
    else
      render action: 'new'
    end
  end

  def edit
    @news_item = NewsItem.find(params[:id])
  end

  def update
    @news_item = NewsItem.find(params[:id])
    if @news_item.update(news_item_params)
      flash[:notice] = 'NewsItem was successfully updated.'
      redirect_to controller: :welcome, action: :index
    else
      render action: :edit
    end
  end

  def destroy
    NewsItem.find(params[:id]).destroy
    redirect_to action: :list
  end
end

private

def news_item_params
  params.require(:news_item).permit(:body, :title)
end
