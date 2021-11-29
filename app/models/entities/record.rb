# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

require_relative 'user'

module MentalHealth
  module Entity
    # Domain entity for record
    class Record < Dry::Struct
      include Dry.Types

      attribute :id,          Integer.optional
      attribute :owner,       User
      attribute :access_time, Strict::Integer
      attribute :fill_time,   Strict::Float

      def to_attr_hash
        to_hash.reject { |key, _| %i[id owner].include? key }
      end
    end
  end
end
