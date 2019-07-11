# frozen_string_literal: true

class Site < ActiveRecord::Base
  validates_presence_of :title
end
