class Model < ApplicationRecord
  acts_as_model

  def self.provider(name = "anthropic")
    Model.select do |model|
      model.provider == name
    end
  end
end
