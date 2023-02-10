# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w( cocacola.scss )
Rails.application.config.assets.precompile += %w( suntory.scss )
Rails.application.config.assets.precompile += %w( asahi.scss )
Rails.application.config.assets.precompile += %w( otsuka.scss )
Rails.application.config.assets.precompile += %w( itoen.scss )
Rails.application.config.assets.precompile += %w( dydo.scss )
Rails.application.config.assets.precompile += %w( kirin.scss )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
