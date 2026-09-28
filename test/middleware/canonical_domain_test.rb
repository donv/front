# frozen_string_literal: true

require 'test_helper'
require Rails.root.join('lib/middleware/canonical_domain')

class CanonicalDomainTest < ActiveSupport::TestCase
  def setup
    app = ->(_env) { [200, { 'content-type' => 'text/plain' }, ['served']] }
    @request = Rack::MockRequest.new(CanonicalDomain.new(app, 'kubosch.no'))
  end

  def test_serves_the_canonical_domain_and_its_subdomains
    assert_equal 'served', @request.get('https://kubosch.no/').body
    assert_equal 'served', @request.get('https://www.kubosch.no/').body
    assert_equal 'served', @request.get('https://blog.kubosch.no/blog_entries/1').body
  end

  def test_redirects_other_domains_keeping_the_subdomain_path_and_query
    assert_redirect 'https://www.kubosch.no/sites?page=2', 'http://www.kubosch.com/sites?page=2'
    assert_redirect 'https://blog.kubosch.no/blog_entries/1', 'https://blog.kubosch.org/blog_entries/1'
    assert_redirect 'https://sports.kubosch.no/weights', 'https://sports.kubosch.net/weights'
  end

  def test_redirects_the_apex_of_other_domains_to_the_canonical_apex
    assert_redirect 'https://kubosch.no/', 'https://kubosch.com/'
  end

  def test_redirects_unknown_subdomains_and_the_heroku_host_to_www
    assert_redirect 'https://www.kubosch.no/', 'https://kubosch-front.herokuapp.com/'
    assert_redirect 'https://www.kubosch.no/status', 'https://anything.kubosch.com/status'
  end

  private

  def assert_redirect(expected_location, url)
    response = @request.get(url)
    assert_equal 301, response.status
    assert_equal expected_location, response.headers['location']
  end
end
