# frozen_string_literal: true

namespace :assets do
  desc "Watch assets for changes and recompile"
  task :watch do
    puts "Watching for asset changes..."
    # Use a simple loop to watch for changes
    loop do
      # Compile assets
      Rake::Task["assets:precompile"].invoke
      puts "Assets compiled at #{Time.now}"
      # Reset the task so it can be invoked again
      Rake::Task["assets:precompile"].reenable
      # Wait for a while before checking again
      sleep 10
    end
  rescue Interrupt
    puts "Asset watching stopped"
  end
end
