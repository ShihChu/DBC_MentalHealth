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
        view 'index', engine: 'html.erb'
      end

      routing.on 'meditation' do
        routing.is do
          routing.get do
            view 'meditation', engine: 'html.erb'
          end
        end
      end

      routing.on 'history' do
        routing.is do
          routing.get do
            view 'history', engine: 'html.erb'
          end
        end
      end

      # routing.on 'history' do
      #   routing.is do
      #     # POST /record/
      #     routing.post do
      #       account = routing.params['account']
      #       routing.redirect "history/#{account}"
      #     end
      #   end
      #   routing.on String do |account|
      #     # GET /record/#{account}
      #     routing.get do
      #       user = Database::UserOrm.where(account: account).first
      #       records = user.owned_records
      #       view 'history', locals: { records: records }
      #     end
      #   end
      # end
    end
  end
end
