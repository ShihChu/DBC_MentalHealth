# frozen_string_literal: true

require_relative 'users'

module MentalHealth
  module Repository
    # Repository for Record Entities
    class Records
      def self.all
        Database::RecordOrm.all.map { |db_record| rebuild_entity(db_record) }
      end

      # def self.find_full_name(owner_name, project_name)
      #   # SELECT * FROM `projects` LEFT JOIN `members`
      #   # ON (`members`.`id` = `projects`.`owner_id`)
      #   # WHERE ((`username` = 'owner_name') AND (`name` = 'project_name'))
      #   db_record = Database::RecordOrm
      #     .left_join(:members, id: :owner_id)
      #     .where(username: owner_name, name: project_name)
      #     .first
      #   rebuild_entity(db_record)
      # end

      # def self.find(entity)
      #   find_origin_id(entity.origin_id)
      # end

      def self.find_id(id)
        db_record = Database::RecordOrm.first(id: id)
        rebuild_entity(db_record)
      end

      # def self.find_origin_id(origin_id)
      #   db_record = Database::RecordOrm.first(origin_id: origin_id)
      #   rebuild_entity(db_record)
      # end

      def self.create(entity)
        raise 'Record already exists' if find(entity)

        db_record = PersistRecord.new(entity).call
        rebuild_entity(db_record)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Record.new(
          db_record.to_hash.merge(
            user: Users.rebuild_entity(db_record.user)
          )
        )
      end

      # Helper class to persist record and its users to database
      class PersistRecord
        def initialize(entity)
          @entity = entity
        end

        def create_record
          Database::RecordOrm.create(@entity.to_attr_hash)
        end

        def call
          user = Users.db_find_or_create(@entity.user)

          create_record.tap do |db_record|
            db_record.update(user: user)
          end
        end
      end
    end
  end
end
