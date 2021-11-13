# frozen_string_literal: true

%w[config app].each do |folder|
  require_relative "#{folder}/init"
end
