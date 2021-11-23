# frozen_string_literal: true

require 'roda'
require 'html'
require 'yaml'

module MentalHealth
  # Web App
  class App < Roda
    plugin :render, engine: 'html.erb', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :public, root: 'app/views/public'
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      routing.public

      # GET /
      routing.root do
        view 'home', engine: 'html.erb'
      end

      routing.on 'meditation' do
        routing.is do
          routing.get do
            view 'meditation', engine: 'html.erb'
          end
        end
      end
    end
  end
end
