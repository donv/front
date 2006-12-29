require 'localization'

class ApplicationController < ActionController::Base
  include Localization
  layout 'mwrt002'
  before_filter :populate_layout

  private
  
  def populate_layout
    @application_title = 'kubosch.no'
    @application_description = ''
    @sidebars = [
      { :title => l(:sections),
        :content => <<EOF
      <ul>
        <li><a href="~cuddles">Lise's photos</a></li>
        <li><a href="~donv">Uwe's Home Page</a></li>

        <li><a href="http://shop.kubosch.no/">The Shop</a></li>
        <li><a href="http://backlog.kubosch.no/">The Backlog</a></li>
        <li><a href="http://blog.kubosch.no/">The Blog</a></li>
      </ul>
EOF
      },
      { :title => l(:links),
        :content => <<EOF
      <ul>
        <li><a href="usage">Webalizer</a></li>
        <li>MRTG
            <ul>
                <li><a href="mrtg/local.html">Local Ethernet</a></li>
                <li><a href="mrtg/gateway_external.html">Gateway External Line</a></li>

                <li><a href="mrtg/gateway_internal.html">Gateway Ethernet</a></li>
        </li>
    </ul>
EOF
      }
    ]
  end
  
end