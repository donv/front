# frozen_string_literal: true

class Site < ApplicationRecord
  validates :title, presence: true
end
