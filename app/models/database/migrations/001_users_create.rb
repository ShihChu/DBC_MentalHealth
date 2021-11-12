# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id

      Integer  :account, unique: true
      Boolean  :is_guided

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
