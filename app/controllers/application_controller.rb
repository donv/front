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
      { title: t(:sections), content: "<ul>#{section_list_items}</ul>" }
    ]
  end

  def section_list_items
    section_links.map { |name, url| %(<li><a href="#{url}">#{name}</a></li>) }.join
  end

  def section_links
    links = [['The Blog', 'http://blog.kubosch.no/']]
    links << ['Sports', sports_section_url] if logged_in?
    links
  end

  def sports_section_url
    Rails.env.production? ? 'https://sports.kubosch.no/' : '/sports'
  end
end
