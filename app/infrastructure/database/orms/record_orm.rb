# frozen_string_literal: true

require 'sequel'

module MentalHealth
  module Database
    # Object Relational Mapper for Record
    class RecordOrm < Sequel::Model(:records)
      many_to_one :owner,
                  class: :'MentalHealth::Database::UserOrm'
      
      one_to_many :owned_answers,
                  class: :'MentalHealth::Database::AnswerOrm',
                  key:   :recordbook_id

      plugin :timestamps, update_on_create: true
    end
  end
end
