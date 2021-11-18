# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    MentalHealth::App.DB.run('PRAGMA foreign_keys = OFF')
    MentalHealth::Database::UserOrm.map(&:destroy)
    MentalHealth::Database::RecordOrm.map(&:destroy)
    MentalHealth::Database::AnswerOrm.map(&:destroy)
    MentalHealth::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
