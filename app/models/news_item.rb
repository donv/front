# frozen_string_literal: true

class NewsItem < ApplicationRecord
  validates :body, :title, presence: true
end
