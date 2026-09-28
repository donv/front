# frozen_string_literal: true

# The blog engine ships with a bare layout of its own. Render its pages inside ours instead, so the
# blog gets the site's header, navigation and sidebars.
Rails.application.config.to_prepare do
  BlogEngine::ApplicationController.layout 'mwrt002'
end
