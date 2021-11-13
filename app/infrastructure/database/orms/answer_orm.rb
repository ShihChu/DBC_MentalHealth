# frozen_string_literal: true

require 'sequel'

module MentalHealth
  module Database
    # Object Relational Mapper for Answer
    class AnswerOrm < Sequel::Model(:answers)
      many_to_one :recordbook,
                  class: :'MentalHealth::Database::RecordOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
