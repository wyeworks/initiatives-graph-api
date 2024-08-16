# frozen_string_literal: true

class HelpersController < ApplicationController
  before_action :set_initiative, only: %i[index create]

  def index
    @current_helpers = Wyeworker
                       .joins("JOIN initiative_helpers " \
                          "ON wyeworkers.id = initiative_helpers.helper_id " \
                          "JOIN initiatives " \
                          "ON initiative_helpers.initiative_id = initiatives.id ")
                       .where(initiatives: { id: @initiative_id })
    render json: @current_helpers
  end

  def create
    if @initiative.update(helpers: helpers_param.map { |id| Wyeworker.find(id) })
      render json: @initiative.helpers, status: :created, location: @initiative
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  private

  def set_initiative
    @initiative_id = params[:initiative_id]
    @initiative = Initiative.find(@initiative_id)
  end

  def helpers_param
    params.require(:_json)
  end
end
