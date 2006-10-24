require 'localization'

class ApplicationController < ActionController::Base
  include Localization
  layout 'mwrt002'
end