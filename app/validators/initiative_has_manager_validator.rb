class InitiativeHasManagerValidator < ActiveModel::Validator
  def validate(initiative)
    unless initiative.source.is_a? Manager or initiative.helpers.any? ->(h){ h.is_a? Manager }
        initiative.errors.add :wyeworker_initiative_belongings, "An initiative must have a manager involved, as a source or as a helper"
    end
  end
end