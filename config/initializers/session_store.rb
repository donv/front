# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# One login for www, blog and sports: the session cookie is issued for the whole kubosch.no domain.
Rails.application.config.session_store :cookie_store, key: '_kubosch_session', domain: :all
