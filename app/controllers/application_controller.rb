class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  protect_from_forgery with: :exception

  layout 'mwrt002'
  before_filter :login_from_cookie
  before_filter :populate_layout

  private
  
  def populate_layout
    @application_title = 'kubosch.no'
    @application_description = ''
    @sidebars = [
      {title: t(:hosted_sites),
          content: <<EOF
      <ul>
        <li><a href="http://augustson.org/" target="_blank">Augustson Consulting</a></li>
        <li><a href="http://jujutsu.no/" target="_blank">Romerike Jujutsu Klubb</a></li>
      </ul>
EOF
      },
      {title: t(:sections),
          content: <<EOF
      <ul>
        <li><a href="~cuddles">Lise's photos</a></li>
        <li><a href="~donv">Uwe's Home Page</a></li>

        <li><a href="http://shop.kubosch.no/">The Shop</a></li>
        <li><a href="http://backlog.kubosch.no/">The Backlog</a></li>
        <li><a href="http://blog.kubosch.no/">The Blog</a></li>
      </ul>
EOF
      },
#       {title: t(:links),
#           content: <<EOF
#       <ul>
#         <li><a href="usage">Webalizer</a></li>
#         <li>MRTG
#             <ul>
#                 <li><a href="mrtg/kubosch.no.html">Main Server</a></li>
#                 <li><a href="mrtg/gateway_external.html">Gateway External Line</a></li>
#         </li>
#     </ul>
# EOF
#       }
    ]
  end
  
end
