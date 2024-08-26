# frozen_string_literal: true

class HelpersController < ApplicationController
  before_action :set_initiative, only: %i[index create destroy]

  def index
    render json: @initiative.helpers
  end

  def create
    @initiative.helpers << helpers_from_body
    if @initiative.save
      render json: @initiative.helpers, status: :created, location: @initiative
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @initiative.helpers.delete(Wyeworker.find(params[:id]))
    if @initiative.save
      head :no_content
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  private

  def set_initiative
    @initiative_id = params[:initiative_id]
    @initiative = Initiative.find(@initiative_id)
  end

  def helpers_from_body
    params
      .require(:_json)
      .map { |id| Wyeworker.find(id) }
  end
end
