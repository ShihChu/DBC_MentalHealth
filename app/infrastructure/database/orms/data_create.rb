# frozen_string_literal: true

USER_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/user.yml'))
RECORD_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/record.yml'))
ANSWER_FILE = YAML.safe_load(File.read('app/infrastructure/database/local/answer.yml'))

module MentalHealth
  module InitializeDatabase
    # InitializeDatabase for Create original data
    class Create
      def self.load
        # user
        USER_FILE.map do |data|
          Database::UserOrm.create(data)
        end
        # # record
        # RECORD_FILE.map do |data|
        #   Database::RecordOrm.create(data)
        # end
        # # answer
        # ANSWER_FILE.map do |data|
        #   Database::AnswerOrm.create(data)
        # end
      end
    end
  end
end
