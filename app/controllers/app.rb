# frozen_string_literal: true

require 'roda'
require 'slim'
require 'yaml'

module MentalHealth
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :public, root: 'app/views/public'
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      routing.public

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'record' do
        routing.is do
          # POST /record/
          routing.post do
          end
        end

        routing.on do
          # GET /record/
          routing.get do
          end
        end
      end
    end
  end
end
