# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module MentalHealth
  module Entity
    # Domain entity for users
    class User < Dry::Struct
      include Dry.Types

      attribute :id,        Integer.optional
      attribute :account,   Strict::String
      attribute :is_guided, Strict::Bool

      def to_attr_hash
        to_hash.reject { |key, _| [:id].include? key }
      end
    end
  end
end
