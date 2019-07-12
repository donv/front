# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  protect_from_forgery with: :exception

  layout 'mwrt002'
  before_action :login_from_cookie
  before_action :populate_layout

  private

  def populate_layout
    @application_title = 'kubosch.no'
    @application_description = ''
    @sidebars = [
      { title: t(:hosted_sites),
        content: <<~HTML
          <ul>
            <li><a href="http://jujutsu.no/" target="_blank">Romerike Jujutsu Klubb</a></li>
          </ul>
        HTML
      },
      { title: t(:sections),
        content: <<~HTML
          <ul>
            <li><a href="~cuddles">Lise's photos</a></li>
            <li><a href="~donv">Uwe's Home Page</a></li>
                      <li><a href="http://shop.kubosch.no/">The Shop</a></li>
            <li><a href="http://backlog.kubosch.no/">The Backlog</a></li>
            <li><a href="http://blog.kubosch.no/">The Blog</a></li>
          </ul>
        HTML
      }
    ]
  end
end
