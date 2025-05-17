# frozen_string_literal: true

namespace :assets do
  desc "Watch assets for changes and recompile"
  task :watch do
    puts "Watching for asset changes..."
    # Use a simple loop to watch for changes
    loop do
      begin
        # Compile CSS separately to avoid cssbundling-rails errors
        system("yarn build:css")
        puts "CSS compiled at #{Time.now}"
        
        # Compile other assets
        system("bin/rails assets:precompile SKIP_CSS=true")
        puts "Assets compiled at #{Time.now}"
      rescue => e
        puts "Error compiling assets: #{e.message}"
      end
      
      # Wait for a while before checking again
      sleep 10
    end
  rescue Interrupt
    puts "Asset watching stopped"
  end
end

# Add a CSS-specific task
namespace :css do
  desc "Build CSS"
  task :build do
    # This is a no-op task that will be handled by cssbundling-rails
    # The actual implementation is in package.json's build:css script
  end
end
