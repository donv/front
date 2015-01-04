class NewsItem < ActiveRecord::Base
  validates_presence_of :body, :title
end
