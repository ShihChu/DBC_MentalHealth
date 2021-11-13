# frozen_string_literal: true

require_relative 'records'

module MentalHealth
  module Repository
    # Repository for Answer Entities
    class Answers
      def self.all
        Database::AnswerOrm.all.map { |db_answer| rebuild_entity(db_answer) }
      end

      # def self.find_full_name(recordbook_name, answer_id)
      #   db_record = Database::AnswerOrm
      #     .left_join(:records, id: :recordbook_id)
      #     .where(account: owner_name, id: record_id)
      #     .first
      #   rebuild_entity(db_record)
      # end

      # def self.find(entity)
      #   find_origin_id(entity.origin_id)
      # end

      def self.find_id(id)
        db_record = Database::AnswerOrm.first(id: id)
        rebuild_entity(db_record)
      end

      # def self.find_origin_id(origin_id)
      #   db_record = Database::RecordOrm.first(origin_id: origin_id)
      #   rebuild_entity(db_record)
      # end

      def self.create(entity)
        raise 'Answer already exists' if find(entity)

        db_record = PersistAnswer.new(entity).call
        rebuild_entity(db_record)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Answer.new(
          db_record.to_hash.merge(
            recordbook: Records.rebuild_entity(db_record.recordbook)
          )
        )
      end

      # Helper class to persist record and its users to database
      class PersistAnswer
        def initialize(entity)
          @entity = entity
        end

        def create_record
          Database::AnswerOrm.create(@entity.to_attr_hash)
        end

        def call
          recordbook = Records.db_find_or_create(@entity.recordbook)

          create_record.tap do |db_record|
            db_record.update(recordbook: recordbook)
          end
        end
      end
    end
  end
end
