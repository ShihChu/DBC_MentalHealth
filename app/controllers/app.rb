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
        session[:watching] ||= []
        view 'home', engine: 'html.erb'
      end

      routing.on 'index' do
        routing.is do
          # POST /index/
          routing.post do
            account = routing.params['account']
            user = Database::UserOrm.where(account: account).first
            routing.redirect "index/#{user.url}"
          end
        end
        routing.on String do |account|
          # GET /index/account
          routing.get do
            user = Database::UserOrm.where(url: account).first
            session[:watching] = user
            view 'index', engine: 'html.erb', locals: { account: user.url }
          end
        end
      end

      routing.on 'meditation' do
        routing.on String do |account|
          routing.get do
            view 'meditation', engine: 'html.erb', locals: { account: session[:watching].url }
          end
        end
      end

      routing.on 'form' do
        routing.on String do |account|
          # GET /form/#{account}
          routing.get do
            view 'form', engine: 'html.erb', locals: { account: session[:watching].url }
          end
        end
      end

      routing.on 'form_complete' do
        routing.is do
          # POST /form_complete/
          routing.post do
            user = session[:watching]
            if user != nil
              record = Database::RecordOrm.create(access_time: 0, owner_id: session[:watching].id)
              num = user.is_guided ? 7 : 3 #題數
              (1..num).each { |i| Database::AnswerOrm.create(recordbook_id: record.id, question_num: i, answer_content: routing.params["#{i}"])}
            end
            routing.redirect "form_complete/#{user.url}}"
          end
        end
        routing.on String do |account|
          # GET /form_complete/#{account}
          routing.get do
            view 'form_complete', engine: 'html.erb', locals: { account: session[:watching].url }
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
