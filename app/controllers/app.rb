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
        records = Repository::For.klass(Entity::Record).all
        view 'home', locals: { records: records }
      end

      routing.on 'record' do
        routing.is do
          # POST /record/
          routing.post do
            account = routing.params['account']
            # Redirect viewer to record page
            routing.redirect "record/#{account}"
          end
        end

        # routing.on String do |user|
        #   # GET /record/user
        #   routing.get do
        #     hobby_introduction = Udemy::CourselistMapper.new(App.config.UDEMY_TOKEN).find('category', hobby)
        #     # Add project to database
        #     Repository::For.entity(hobby_introduction).create(hobby_introduction)

        #     view 'introhobby', locals: { hobby: hobby_introduction }
        #   end
        # end
      end
    end
  end
end
