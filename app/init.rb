# frozen_string_literal: true

%w[models infrastructure controllers].each do |folder|
  require_relative "#{folder}/init"
end
