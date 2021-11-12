# frozen_string_literal: true

%w[models controllers].each do |folder|
  require_relative "#{folder}/init"
end
