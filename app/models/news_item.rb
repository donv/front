# frozen_string_literal: true

class NewsItem < ActiveRecord::Base
  validates_presence_of :body, :title
end
