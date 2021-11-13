# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:answers) do
      primary_key :id
      foreign_key :recordbook_id, :records
      
      String  :answer_content
      Integer :question_num

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
