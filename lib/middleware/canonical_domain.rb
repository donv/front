# frozen_string_literal: true

# Redirects requests for any other domain (kubosch.com, kubosch.net, kubosch.org, the herokuapp.com
# host) to the same page on the canonical domain. Known subdomains are kept, anything else goes to
# www, and the apex of another domain goes to the canonical apex.
class CanonicalDomain
  SUBDOMAINS = %w[www blog sports].freeze

  def initialize(app, domain)
    @app = app
    @domain = domain
  end

  def call(env)
    request = Rack::Request.new(env)
    return @app.call(env) if canonical?(request.host)

    location = "https://#{canonical_host(request.host)}#{request.fullpath}"
    [301, { 'location' => location, 'content-type' => 'text/plain' }, ["Moved to #{location}\n"]]
  end

  private

  def canonical?(host)
    host == @domain || host.end_with?(".#{@domain}")
  end

  def canonical_host(host)
    labels = host.split('.')
    return @domain if labels.size <= 2

    subdomain = labels[0..-3].join('.')
    subdomain = 'www' unless SUBDOMAINS.include?(subdomain)
    "#{subdomain}.#{@domain}"
  end
end
