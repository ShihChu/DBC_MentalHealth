# frozen_string_literal: true

module MentalHealth
  module Repository
    # Repository for Users
    class Users
      def self.find_id(id)
        rebuild_entity Database::UserOrm.first(id: id)
      end

      def self.find_account(account)
        rebuild_entity Database::UserOrm.first(account: account)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::User.new(
          id:        db_record.id,
          account:   db_record.account,
          is_guided: db_record.is_guided
        )
      end

      # def self.rebuild_many(db_records)
      #   db_records.map do |db_member|
      #     Members.rebuild_entity(db_member)
      #   end
      # end

      def self.db_find_or_create(entity)
        Database::UserOrm.find_or_create(entity.to_attr_hash)
      end
    end
  end
end
