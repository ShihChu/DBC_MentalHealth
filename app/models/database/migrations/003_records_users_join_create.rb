# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:records_users) do
      primary_key %i[record_id user_id]
      foreign_key :record_id, :records
      foreign_key :user_id, :users

      index %i[record_id user_id]
    end
  end
end
