# frozen_string_literal: true

require 'base64'
require 'rbnacl'

module MentalHealth
  class SecureMessage
    def self.encoded_random_bytes(length)
      bytes = RbNaCl::Random.random_bytes(length)
      Base64.strict_encode64 bytes
    end

    def self.generate_key
      encoded_random_bytes(RbNaCl::SecretBox.key_bytes)
    end
  end
end
