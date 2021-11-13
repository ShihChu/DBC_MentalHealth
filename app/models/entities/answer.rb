# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

require_relative 'record'

module MentalHealth
  module Entity
    # Domain entity for answer
    class Answer < Dry::Struct
      include Dry.Types

      attribute :id,             Integer.optional
      attribute :recordbook,     Record
      attribute :answer_content, Strict::String
      attribute :question_num,   Strict::Integer

      def to_attr_hash
        to_hash.reject { |key, _| %i[id recordbook].include? key }
      end
    end
  end
end
