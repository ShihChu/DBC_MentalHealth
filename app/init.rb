# frozen_string_literal: true

%w[models infrastructure controllers lib].each do |folder|
  require_relative "#{folder}/init"
end
