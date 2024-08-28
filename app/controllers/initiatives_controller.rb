# frozen_string_literal: true

class InitiativesController < ApplicationController
  before_action :set_initiative, only: %i[show destroy update]

  def index
    @initiatives = Initiative.all
  end

  # POST
  def create
    @initiative = Initiative.create(initiative_params)
    render json: @initiative.errors, status: :unprocessable_entity unless @initiative.save
  end

  # PATCH/PUT
  def update
    render json: @initiative.errors, status: :unprocessable_entity unless @initiative.update(initiative_params)
  end

  # DELETE
  def destroy
    if @initiative.destroy
      head :no_content
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  private

  def set_initiative
    @initiative = Initiative.find(params[:id])
  end

  def initiative_params
    params
      .require(:initiative)
      .permit(:title, :description, :startdate, :owner_id, :parent_id)
  end
end
