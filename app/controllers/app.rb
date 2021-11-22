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

      routing.on 'index' do
        routing.is do
          # POST /index/
          routing.post do
            account = routing.params['account']
            user = Database::UserOrm.where(account: account).first
            account = user.url
            routing.redirect "index/#{account}"
          end
        end
        routing.on String do |account|
          # GET /index/account
          routing.get do
            view 'index', engine: 'html.erb', locals: { account: account }
          end
        end
      end

      routing.on 'meditation' do
        routing.is do
          routing.get do
            view 'meditation', engine: 'html.erb'
          end
        end
      end

      routing.on 'history-test' do
        routing.is do
          # POST /history/
          routing.post do
            account = routing.params['account']
            routing.redirect "history-test/#{account}"
          end
        end
        routing.on String do |account|
          # GET /history/#{account}
          routing.get do
            user = Database::UserOrm.where(url: account).first
            records = user.owned_records
            view 'history-test', engine: 'html.erb', locals: { account: account, records: records }
          end
        end
      end

      routing.on 'history-each-test' do
        routing.is do
          # POST /history-each/
          routing.post do
            account = routing.params['account']
            record = routing.params['record']
            binding.pry
            # account = Database::RecordOrm.where(id: record).first.owner
            routing.redirect "history-each-test/#{record}/#{account}"
          end
        end
        routing.on String do |record|
          # GET /history-each-test/#{record}
          routing.get do
            record = Database::RecordOrm.where(id: record).first
            answers = record.owned_answers
            view 'history-each-test', engine: 'html.erb', locals: { answers: answers }
          end
        end
      end
    end
  end
end
