# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w[mwrt002.css serviceworker.js manifest.json]

# Precompile assets serially. sassc-rails injects its asset helpers (asset-url, image-url)
# into a module shared by all threads for the duration of each render, so concurrent
# stylesheet compiles can see the wrong helper and fail with "cannot load such file -- sass".
Rails.application.config.assets.configure { |env| env.export_concurrent = false }
