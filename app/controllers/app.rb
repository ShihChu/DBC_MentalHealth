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

      routing.on 'report' do
        routing.is do
          # POST /record/
          routing.post do
            account = routing.params['account']
            routing.redirect "report/#{account}"
          end
        end

        routing.on String do |account|
           # GET /record/#{account}
          routing.get do
            user = Database::UserOrm.where(account: account).first
            #binding.pry
            records = user.owned_records
            view 'report', locals: { records: records }
          end
        end
      end
    end
  end
end
