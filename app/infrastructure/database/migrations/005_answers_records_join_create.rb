# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:answers_records) do
      primary_key %i[answer_id record_id]
      foreign_key :answer_id, :answers
      foreign_key :record_id, :records

      index %i[answer_id record_id]
    end
  end
end
