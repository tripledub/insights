# frozen_string_literal: true

namespace :assets do
  desc "Watch assets for changes and recompile"
  task :watch do
    sh "yarn build --watch"
  end
end
