# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:records) do
      primary_key :id
      foreign_key :owner_id, :users
      
      Integer :access_time
      Float   :fill_time

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
